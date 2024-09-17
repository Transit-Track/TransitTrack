from cairo import Status
from fastapi import HTTPException
from features.real_time_tracking.repositories.driver_repo import DriverRepository
from features.real_time_tracking.repositories.route_repo import RouteRepository
from features.route_optimization.repositories.traffic_status import GoogleMapsAPI
from core.config.db import client as db

class BusRepository:
    def __init__(self):
        self.db = db.transittrack.buses
        self.route_repo = RouteRepository()
        self.driver_repo = DriverRepository()
        self.google_maps = GoogleMapsAPI()
        
    async def search_bus_by_route(self, start_station, end_station):
        all_buses = await self.db.find().to_list(length=None)
        # print(start_station, end_station)
        buses = []
        for bus in all_buses:
            print("Bus: ", bus)
            if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                
                if bus['capacity'] > 0 and bus['current_route']:
                    driver = await self.driver_repo.get_driver_by_id(bus['driver_id'])
                    if driver:
                        origin = ",".join([driver['location']['latitude'], driver['location']['longitude']])
                        destination = bus['current_route']['stations'][-1]
                        waypoints = "|".join([station['name'] for station in bus['current_route']['stations'][driver['state']:-1]])
                        arrival_time = self.google_maps.get_route_time(origin, destination, waypoints)
                        bus['arrival_time'] = arrival_time
                        buses.append(bus)
        return sorted(buses, key=lambda bus: bus['arrival_time'])