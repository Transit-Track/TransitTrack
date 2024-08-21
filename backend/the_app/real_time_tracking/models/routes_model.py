from typing import List
from real_time_tracking.models.station_model import Station
from pydantic import BaseModel


class Route (BaseModel):
    route_id: int
    stations: List[Station]
    distance: float