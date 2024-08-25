from pydantic import BaseModel

class Location(BaseModel):
    longitude: float
    latitude: float
    
    def to_geojson(self):
        return {
            "type": "Point",
            "coordinates": [self.longitude, self.latitude]
        }
    