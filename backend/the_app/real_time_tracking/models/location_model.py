from pydantic import BaseModel

class Location(BaseModel):
    latitude: float
    longitude: float
    
    def to_geojson(self):
        return {
            "type": "Point",
            "coordinates": [self.longitude, self.latitude]
        }
    