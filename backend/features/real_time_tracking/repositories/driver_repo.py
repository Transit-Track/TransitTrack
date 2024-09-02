from core.config.db import client as db
from features.auth.repositories.user_repo import UserRepository
from fastapi import HTTPException, status



class DriverRepository:
    def __init__(self):
        self.db = db.local.transittrack.users.drivers
        self.user_repo = UserRepository()

    
    async def update_location(self, token, location):
        user = await self.user_repo.read_users_me(token)
        result = await self.db.update_one({"phone_number": user['phone_number']}, {"$set": {"location": location.__dict__}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver not found"
            )
        return result
    
    async def get_drivers_location(self, phone_number):
        driver = await self.db.find_one({"phone_number": phone_number})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {phone_number} not found"
            )
        return driver['location']