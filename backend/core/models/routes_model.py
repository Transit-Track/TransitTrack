from typing import List
from .station_model import Station
from pydantic import BaseModel


class Route (BaseModel):
    route_id: int = None
    stations: List[Station]
    distance: float
    _id_counter = 0

    def __init__(self, **data):
        super().__init__(**data)
        if self.route_id is None:
            self.route_id = self._generate_id()

    @classmethod
    def _generate_id(cls):
        cls._id_counter += 1
        return cls._id_counter