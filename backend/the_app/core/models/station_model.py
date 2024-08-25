from pydantic import BaseModel

from real_time_tracking.models.location_model import Location

class Station(BaseModel):
    station_id: int
    name: str
    location: Location

class StationIn(BaseModel):
    name: str
