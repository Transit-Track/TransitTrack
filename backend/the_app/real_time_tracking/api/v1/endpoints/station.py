from typing import List
from fastapi import APIRouter, Body, Depends, Query

from real_time_tracking.models.station_model import StationOut
from real_time_tracking.models.location_model import Location
from real_time_tracking.repositories.station_repo import StationRepository
from real_time_tracking.services.station_service import StationService

station = APIRouter()

station_service = StationService(StationRepository())
def get_station_service():
    return station_service

@station.post('/stations', response_model=List[StationOut])
async def get_nearby_stations(
    locations: List[Location] = Body(..., description="List of locations"),
    radius: int = Query(..., description="Radius to search for nearby stations"),
    station_service: StationService = Depends(get_station_service)
):
    results = []
    for location in locations:
        print('at gateway')
        stations = await station_service.get_nearby_station(location, radius)
        results.extend(stations)
    return results