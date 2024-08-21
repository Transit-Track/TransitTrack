# entities/driver.py
from real_time_tracking.models.location_model import Location
from pydantic import BaseModel


class Driver (BaseModel):
    driver_id: int
    name: str
    license_number: str
    password: str
    phone_number: str
    location: Location
    