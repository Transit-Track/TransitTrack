from cairo import Status
from fastapi import HTTPException
from features.real_time_tracking.repositories.route_repo import RouteRepository
from core.config.db import client as db

class BusRepository:
    def __init__(self):
        self.db = db.transittrack.buses
        self.route_repo = RouteRepository()
        
    async def search_bus_by_route(self, start_station, end_station):
        all_buses = await self.db.find().to_list(length=None)
        # print(start_station, end_station)
        buses = []
        for bus in all_buses:
            print("Bus: ", bus)
            if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                if bus['capacity'] > 0:
                    buses.append(bus)
        return buses
    
    async def add_bus_to_my_route(self, bus_id):
        result = await self.db.update_one({"bus_id": int(bus_id)}, {"$set": {"is_my_route": True}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=Status.HTTP_404_NOT_FOUND,
                detail=f"Bus not found"
            )

        return 'Succesfully added bus to my route'

    async def remove_bus_from_my_route(self, bus_id):
        result = await self.db.update_one({"bus_id": int(bus_id)}, {"$set": {"is_my_route": False}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=Status.HTTP_404_NOT_FOUND,
                detail=f"Bus not found"
            )

        return 'Succesfully removed bus from my route'
    
    async def get_bus_by_id(self, bus_id):
        bus = await self.db.find_one({"bus_id": int(bus_id)})
        if bus is None:
            raise HTTPException(
                status_code=Status.HTTP_404_NOT_FOUND,
                detail=f"Bus with id {bus_id} not found"
            )
        return bus
    
    async def get_my_route_buses(self):
        my_route_buses = await self.db.find({"is_my_route": True}).to_list(length=None)
        return my_route_buses