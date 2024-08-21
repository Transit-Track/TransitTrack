from fastapi import APIRouter, Depends

from real_time_tracking.models.location_model import Location
from real_time_tracking.services.driver_service import DriverService
from real_time_tracking.repositories.driver_repo import DriverRepository

driver = APIRouter()

driverService = DriverService(DriverRepository())
def get_driverService():
    return driverService

@driver.get("/driver")
async def get_drivers_location(driver_id, driver_service:DriverService = Depends(get_driverService)):
    return await driverService.get_drivers_location(driver_id)

@driver.put("/driver")
async def update_location(driver_id, location : Location, driver_service: DriverService = Depends(get_driverService)):
    return await driverService.update_location(driver_id, location)