from features.real_time_tracking.repositories.bus_repo import BusRepository
from core.models.bus_model import Bus

class BusService:
    def __init__(self, repo: BusRepository):
        self.repo = repo

    
    async def search_bus_by_route(self, start_station, end_station):
        found_buses = await self.repo.search_bus_by_route(start_station, end_station)
        return [Bus(**bus) for bus in found_buses]
