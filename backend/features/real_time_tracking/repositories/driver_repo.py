from bson import ObjectId
from core.config.db import client as db
from core.models.location_model import Location
from features.auth.repositories.user_repo import UserRepository
from fastapi import HTTPException, status



class DriverRepository:
    def __init__(self):
        self.db = db.transittrack.users.drivers
        self.user_repo = UserRepository()
        self.bus_db = db.transittrack.buses
        # self.ticket_repo = TicketRepository()

    
    async def update_location(self, token, location:Location):
        driver = await self.user_repo.read_users_me(token)
        result = await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"location": location.__dict__}})
        
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver not found"
            )
            
        bus = self.bus_db.find_one({"bus_id": driver['bus_id']})
        stations = bus['route']['stations']
        if driver["state"] == len(stations) - 1:
            if location == stations[driver["state"] + 1]:
                driver["state"] += 1
                await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"state": driver["state"]}})
                # update bus capacity by number of tickets whose destination is current. station
                tickets = await self.ticket_repo.db.find({"destination": stations[driver['state']]}).to_list(length=None)
                self.bus_db.update_one({"bus_id":bus['id']}, {"$set":{"capacit": bus["capacity"] + tickets.count()}})
                
            
            if driver["state"] == len(stations) - 2:
                await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"state": -1}})
                await self.bus_db.update_one({"bus_id": driver['bus_id']}, {"$set": {"idle": True}})
        
        return {
            "matched_count": result.matched_count,
            "modified_count": result.modified_count,
            "acknowledged": result.acknowledged
        }
    
    async def get_drivers_location(self, phone_number):
        driver = await self.db.find_one({"phone_number": '+'+phone_number})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {phone_number} not found"
            )
        return driver['location']
    
    async def get_driver_by_id(self, driver_id):
        try:
            object_id = ObjectId(driver_id)
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid ObjectId")
        
        driver = await self.db.find_one({"_id": object_id})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {driver_id} not found"
            )
        return driver

    async def activate_route(self, route_id, token):
        driver = await self.user_repo.read_users_me(token)
        # update the the current route of the bus to be the route with given route id
        bus = self.bus_db.find_one({"bus_id": driver['bus_id']})
        result = await self.bus_db.update_one({"bus_id": bus['bus_id']}, {"$set": {"route_id": route_id}})
        driver["state"] = 0
        return result
    
