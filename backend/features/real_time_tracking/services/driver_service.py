from features.real_time_tracking.repositories.driver_repo import DriverRepository
from core.models.location_model import Location

class DriverService:
    def __init__(self, repo: DriverRepository):
        self.repo = repo

    async def get_drivers_location(self, phone_number):
        location = await self.repo.get_drivers_location(phone_number)
        return Location(**location)
    async def update_location(self, token, location):
        return await self.repo.update_location(token, location)
    async def activate_route(self, route_id, token):
        return await self.repo.activate_route(route_id, token)