from fastapi import HTTPException
from features.real_time_tracking.repositories.route_repo import RouteRepository
from features.route_optimization.repositories.traffic_status import GoogleMapsAPI
from core.config.db import client as db

class BusRepository:
    def __init__(self):
        self.db = db.transittrack.buses
        self.driver_db = db.transittrack.users.drivers
        self.route_repo = RouteRepository()
        self.google_maps = GoogleMapsAPI()
        
    async def search_bus_by_route(self, start_station, end_station):
        all_buses = await self.db.find().to_list(length=None)
        buses = []
        for bus in all_buses:
            # print("Bus: ", bus)
            if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                
                if bus['capacity'] > 0 and bus['current_route']:
                    driver = await self.find_driver_by_id(bus['driver_id'])
                    if driver:
                        waypoints = bus['current_route']['stations'][driver['state']:-1]
                        arrival_time = self.google_maps.get_arrival_time_through_waypoints(waypoints)
                        bus['arrival_time'] = arrival_time
                        buses.append(bus)
        return sorted(buses, key=lambda bus: bus['arrival_time'])
    
    async def find_driver_by_id(self,driver_id):
        driver = await self.driver_db.find_one({'driver_id': driver_id})
        return driver