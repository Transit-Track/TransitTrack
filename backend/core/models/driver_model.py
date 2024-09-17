# entities/driver.py
from .user_model import User
from .location_model import Location
from pydantic import BaseModel

class Driver(User):
    bus_id: int = None
    state: int = None # to keep the station that the driver is at
    license_number: str
    location: Location

class DriverOnBus(BaseModel):
    phone_number:str
    location: Location