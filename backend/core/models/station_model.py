from pydantic import BaseModel

from core.models.location_model import Location

class Station(BaseModel):
    station_id: int
    name: str
    location: Location

class StationIn(BaseModel):
    name: str
