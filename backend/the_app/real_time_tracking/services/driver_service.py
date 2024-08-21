from real_time_tracking.repositories.driver_repo import DriverRepository

class DriverService:
    def __init__(self, repo: DriverRepository):
        self.repo = repo

    async def get_drivers_location(self, driver_id):
        return await self.repo.get_drivers_location(driver_id)
    async def update_location(self, driver_id, location):
        return await self.repo.update_location(driver_id, location)