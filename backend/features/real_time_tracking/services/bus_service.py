from features.real_time_tracking.repositories.bus_repo import BusRepository
from core.models.bus_model import *
from features.real_time_tracking.repositories.driver_repo import DriverRepository

class BusService:
    def __init__(self, repo: BusRepository):
        self.repo = repo
        self.driver_repo = DriverRepository()
    
    async def search_bus_by_route(self, start_station, end_station):
        found_buses = await self.repo.search_bus_by_route(start_station, end_station)
        result = []
        for bus in found_buses:
            result.append(BusOut(**bus))
        return result
    
    async def add_bus_to_my_route(self, bus_id):
        return await self.repo.add_bus_to_my_route(bus_id)
    
    async def remove_bus_from_my_route(self, bus_id):
        return await self.repo.remove_bus_from_my_route(bus_id)
    
    async def get_my_route_buses(self):
        buses = await self.repo.get_my_route_buses()
        my_route_buses = []
        for bus in buses:
            my_route_buses.append(await self.get_bus_by_id(bus['bus_id'])) 
        return my_route_buses
    
    async def get_bus_by_id(self, bus_id):
        bus = await self.repo.get_bus_by_id(int(bus_id))
        if 'driver_id' not in bus:
            bus['driver_id'] = 21  
        return Bus(**bus)