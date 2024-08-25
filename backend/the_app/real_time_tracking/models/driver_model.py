# entities/driver.py
from real_time_tracking.models.location_model import Location
from pydantic import BaseModel




class DriverOnBus(BaseModel):
    driver_id: int
    name: str
    license_number: str
    phone_number: str
    location: Location
    
class Driver (DriverOnBus):
    driver_id: int
    name: str
    license_number: str
    password: str
    phone_number: str
    location: Location