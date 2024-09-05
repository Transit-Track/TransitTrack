from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordBearer

from core.models.location_model import Location
from features.real_time_tracking.services.driver_service import DriverService
from features.real_time_tracking.repositories.driver_repo import DriverRepository

driver = APIRouter()
oath2_schema = OAuth2PasswordBearer(tokenUrl="token")


driverService = DriverService(DriverRepository())
def get_driverService():
    return driverService

@driver.get("/driver")
async def get_drivers_location(phone_number, driver_service:DriverService = Depends(get_driverService)):
    return await driver_service.get_drivers_location(phone_number)

@driver.put("/driver")
async def update_location(location : Location,token:str = Depends(oath2_schema), driver_service: DriverService = Depends(get_driverService)):
    return await driver_service.update_location(token,location)