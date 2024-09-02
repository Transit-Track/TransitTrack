from features.real_time_tracking.repositories.station_repo import StationRepository
class StationService:
    def __init__(self, repo: StationRepository):
        self.repo = repo

    async def get_nearby_station(self, Location, radius):
        return await self.repo.get_nearby_station(Location, radius)
   