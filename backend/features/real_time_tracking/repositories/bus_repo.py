from fastapi import HTTPException, status
# from grpc import Status
# from features.real_time_tracking.repositories.driver_repo import DriverRepository
from features.real_time_tracking.repositories.route_repo import RouteRepository
from features.route_optimization.repositories.traffic_status import GoogleMapsAPI
from core.config.db import client as db

class BusRepository:
    def __init__(self):
        self.db = db.transittrack.buses
        self.driver_db = db.transittrack.users.drivers
        self.route_repo = RouteRepository()
        self.google_maps = GoogleMapsAPI()
        
    # async def search_bus_by_route(self, start_station, end_station):
    #     all_buses = await self.db.find().to_list(length=None)
    #     # print(start_station, end_station)
    #     buses = []
    #     for bus in all_buses:
    #         print("Bus: ", bus)
    #         if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                
    #             if bus['capacity'] > 0 and bus['current_route']:
    #                 driver = await self.find_driver_by_id(bus['driver_id'])
    #                 if driver:
    #                     origin = ",".join([driver['location']['latitude'], driver['location']['longitude']])
    #                     destination = bus['current_route']['stations'][-1]
    #                     waypoints = "|".join([station['name'] for station in bus['current_route']['stations'][driver['state']:-1]])
    #                     arrival_time = self.google_maps.get_route_time(origin, destination, waypoints)
    #                     bus['arrival_time'] = arrival_time
    #                     buses.append(bus)
    #     return sorted(buses, key=lambda bus: bus['arrival_time'])
    async def search_bus_by_route(self, start_station, end_station):
        all_buses = await self.db.find().to_list(length=None)
        buses = []
        for bus in all_buses:
            if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                if bus['capacity'] > 0:
                    buses.append(bus)
        return buses

    async def add_bus_to_my_route(self, bus_id):
        result = await self.db.update_one({"bus_id": int(bus_id)}, {"$set": {"is_my_route": True}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Bus not found"
            )
        return 'Succesfully added bus to my route'
    async def remove_bus_from_my_route(self, bus_id):
        result = await self.db.update_one({"bus_id": int(bus_id)}, {"$set": {"is_my_route": False}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Bus not found"
            )
        return 'Succesfully removed bus from my route'
    
    async def get_bus_by_id(self, bus_id):
        bus = await self.db.find_one({"bus_id": int(bus_id)})
        if bus is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Bus with id {bus_id} not found"
            )
        return bus
    
    async def get_my_route_buses(self):
        my_route_buses = await self.db.find({"is_my_route": True}).to_list(length=None)
        return my_route_buses
    
    async def find_driver_by_id(self,driver_id):
        driver = await self.driver_db.find_one({'driver_id': driver_id})
        return driver