from core.config.db import client as db
from core.models.location_model import Location
from features.auth.repositories.user_repo import UserRepository
from features.real_time_tracking.repositories.bus_repo import BusRepository
from fastapi import HTTPException, status



class DriverRepository:
    def __init__(self):
        self.db = db.local.transittrack.users.drivers
        self.user_repo = UserRepository()
        self.bus_repo = BusRepository()
        # self.ticket_repo = TicketRepository()

    
    async def update_location(self, token, location:Location):
        driver = await self.user_repo.read_users_me(token)
        result = await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"location": location.__dict__}})
        
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver not found"
            )
            
        bus = self.bus_repo.db.find_one({"bus_id": driver['bus_id']})
        stations = bus['route']['stations']
        if driver["state"] == len(stations) - 1:
            if location == stations[driver["state"] + 1]:
                driver["state"] += 1
                await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"state": driver["state"]}})
                # update bus capacity by number of tickets whose destination is current. station
                tickets = await self.ticket_repo.db.find({"destination": stations[driver['state']]}).to_list(length=None)
                self.bus_repo.db.update_one({"bus_id":bus['id']}, {"$set":{"capacit": bus["capacity"] + tickets.count()}})
                
            
            if driver["state"] == len(stations) - 2:
                await self.db.update_one({"phone_number": driver['phone_number']}, {"$set": {"state": -1}})
                await self.bus_repo.db.update_one({"bus_id": driver['bus_id']}, {"$set": {"idle": True}})
        
        return result
    
    async def get_drivers_location(self, phone_number):
        driver = await self.db.find_one({"phone_number": phone_number})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {phone_number} not found"
            )
        return driver['location']

    async def activate_route(self, route_id, token):
        driver = await self.user_repo.read_users_me(token)
        # update the the current route of the bus to be the route with given route id
        bus = self.bus_repo.db.find_one({"bus_id": driver['bus_id']})
        result = await self.bus_repo.db.update_one({"bus_id": bus['bus_id']}, {"$set": {"route_id": route_id}})
        driver["state"] = 0
        return result