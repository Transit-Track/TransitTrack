from typing import List
from .station_model import Station
from pydantic import BaseModel


class Route (BaseModel):
    route_id: int
    stations: List[Station]
    distance: float