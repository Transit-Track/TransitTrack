from features.real_time_tracking.repositories.driver_repo import DriverRepository

class DriverService:
    def __init__(self, repo: DriverRepository):
        self.repo = repo

    async def get_drivers_location(self, phone_number):
        return await self.repo.get_drivers_location(phone_number)
    async def update_location(self, token, location):
        return await self.repo.update_location(token, location)