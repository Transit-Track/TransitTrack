from core.config.db import client as db
from fastapi import HTTPException, status


class DriverRepository:
    def __init__(self):
        self.db = db.local.transittrack.drivers

    
    async def update_location(self, driver_id, location):
        result = await self.db.update_one({"driver_id": driver_id}, {"$set": {"location": location.__dict__}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {driver_id} not found"
            )
        return result
    
    async def get_drivers_location(self, driver_id):
        driver = await self.db.find_one({"driver_id": driver_id})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {driver_id} not found"
            )
        return driver['location']