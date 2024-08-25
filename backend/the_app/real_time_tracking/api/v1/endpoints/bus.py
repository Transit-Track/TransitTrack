from typing import List
from fastapi import APIRouter, Depends

from real_time_tracking.models.station_model import Station, StationIn
from real_time_tracking.models.bus_model import Bus
from real_time_tracking.repositories.bus_repo import BusRepository
from real_time_tracking.services.bus_service import BusService

bus = APIRouter()

busService = BusService(BusRepository())
def get_busService():
    return busService

@bus.get("/search_bus_by_route", response_model=List[Bus])
async def getBuses(start_station, end_station, bus_service: BusService = Depends(get_busService)):
    return await bus_service.search_bus_by_route(start_station, end_station)
