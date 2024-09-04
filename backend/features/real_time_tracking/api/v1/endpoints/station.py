from typing import List
from fastapi import APIRouter, Depends, Query

from core.models.station_model import StationOut
from core.models.location_model import Location
from features.real_time_tracking.repositories.station_repo import StationRepository
from features.real_time_tracking.services.station_service import StationService

station = APIRouter()

station_service = StationService(StationRepository())
def get_station_service():
    return station_service

@station.get('/stations', response_model=List[StationOut])
async def get_nearby_stations(latitude: float = Query(..., description="Latitude of the location"),
    longitude: float = Query(..., description="Longitude of the location"),
    radius: int = Query(..., description="Radius to search for nearby stations"),
    service: StationService = Depends(get_station_service)
):
    location = Location(latitude=latitude, longitude=longitude)
    return await station_service.get_nearby_station(location, radius)