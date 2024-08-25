from features.real_time_tracking.repositories.route_repo import RouteRepository
from core.config.db import client as db

class BusRepository:
    def __init__(self):
        self.db = db.local.transittrack.buses
        self.route_repo = RouteRepository()
        
    async def search_bus_by_route(self, start_station, end_station):
        all_buses = await self.db.find().to_list(length=None)
        buses = []
        for bus in all_buses:
            
            if await self.route_repo.is_route_exist(bus['route_id'], start_station, end_station):
                buses.append(bus)
        return buses