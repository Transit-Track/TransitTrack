from typing import Any
from pydantic import BaseModel, validator

from core.models.location_model import *

class Station(BaseModel):
    station_id: int
    name: str
    # location: Location
    geo_location: Location

class StationIn(BaseModel):
    name: str

class StationOut(BaseModel):
    name: str