from bson import ObjectId
from core.config.db import client as db
from features.auth.repositories.user_repo import UserRepository
from fastapi import HTTPException, status



class DriverRepository:
    def __init__(self):
        self.db = db.transittrack.users.drivers
        self.user_repo = UserRepository()

    
    async def update_location(self, token, location):
        user = await self.user_repo.read_users_me(token)
        result = await self.db.update_one({"phone_number": user['phone_number']}, {"$set": {"location": location.__dict__}})
        if result.matched_count == 0:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver not found"
            )
        return {
            "matched_count": result.matched_count,
            "modified_count": result.modified_count,
            "acknowledged": result.acknowledged
        }
    
    async def get_drivers_location(self, phone_number):
        driver = await self.db.find_one({"phone_number": '+'+phone_number})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {phone_number} not found"
            )
        return driver['location']
    
    async def get_driver_by_id(self, driver_id):
        try:
            object_id = ObjectId(driver_id)
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid ObjectId")
        
        driver = await self.db.find_one({"_id": object_id})
        if driver is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Driver with id {driver_id} not found"
            )
        return driver