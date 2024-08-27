from fastapi import HTTPException
from core.config.db import client as db
from core.models.location_model import Location


class StationRepository:
    def __init__(self):
        self.db = db.local.transittrack.stations
    
    async def get_nearby_station(self, location: Location, radius: int):
        # Validate coordinates
        if not (-180 <= location.longitude <= 180):
            raise HTTPException(status_code=400, detail="Longitude must be between -180 and 180")
        if not (-90 <= location.latitude <= 90):
            raise HTTPException(status_code=400, detail="Latitude must be between -90 and 90")

        query = {
            "location": {
                "$near": {
                    "$geometry": {
                        "type": "Point",
                        "coordinates": [location.longitude, location.latitude]
                    },
                    "$maxDistance": radius
                }
            }
        }
        cursor = self.db.find(query)
        stations = await cursor.to_list(length=None)  # Convert cursor to list
        return stations

  