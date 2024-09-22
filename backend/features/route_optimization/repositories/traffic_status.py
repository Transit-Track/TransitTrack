import requests

class GoogleMapsAPI:
    def __init__(self, api_key=''):
        self.api_key = api_key

    def get_route_time(self, origin, destination, waypoints):
        url = f"https://maps.googleapis.com/maps/api/directions/json?origin={origin}&destination={destination}&waypoints={waypoints}&mode=driving&key={self.api_key}"
        response = requests.get(url)
        data = response.json()
        
        if data['status'] == 'OK':
            # Sum the duration of all legs
            total_duration = sum(leg['duration']['value'] for leg in data['routes'][0]['legs'])
            return total_duration / 60  # Convert seconds to minutes
        else:
            raise Exception(f"Error fetching route data: {data['status']}")
    
    def get_arrival_time(self,  latitude, longitude, start_station):
        current_location = f"{latitude},{longitude}"
        url = f"https://maps.googleapis.com/maps/api/directions/json?origin={current_location}&destination={start_station}&mode=driving&key={self.api_key}"
        response = requests.get(url)
        data = response.json()
        
        if data['status'] == 'OK':
            # Get the duration of the route
            duration = data['routes'][0]['legs'][0]['duration']['value']
            return duration / 60  # Convert seconds to minutes
        else:
            raise Exception(f"Error fetching route data: {data['status']}")