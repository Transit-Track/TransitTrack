# entities/driver.py
from .user_model import User
from .location_model import Location
from pydantic import BaseModel

class Driver(User):
    driver_id: int
    license_number: str
    location: Location

class DriverOnBus(BaseModel):
    phone_number:str
    location: Location