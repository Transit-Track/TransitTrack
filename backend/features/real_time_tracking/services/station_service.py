from features.real_time_tracking.repositories.station_repo import StationRepository
from core.models.station_model import *
class StationService:
    def __init__(self, repo: StationRepository):
        self.repo = repo

    async def get_nearby_station(self, Location, radius):
        stations = await self.repo.get_nearby_station(Location, radius)
        return [StationOut(**station) for station in stations]
   