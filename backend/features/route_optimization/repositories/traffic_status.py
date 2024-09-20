import requests

class GoogleMapsAPI:
    def __init__(self, api_key=''):
        self.api_key = api_key
        self.arrival_time_cache = {}

    def get_arrival_time_through_waypoints(self, waypoints):
        total_time = 0
        for i in range(len(waypoints) - 1):
            start = waypoints[i]['name']
            destination = waypoints[i + 1]['name']
            total_time += self.get_arrival_time(start, destination)
        
        return total_time/60 # convert to minutes
            
    
    def get_arrival_time(self,  start, destination, start_station):
        if (start, destination) in self.arrival_time_cache:
            return self.arrival_time_cache[(start, destination)]
        
        arrival_time = self.general_arrival_time(start_station, destination)
        self.arrival_time_cache[(start, destination)] = arrival_time
        return arrival_time
    
    def general_arrival_time(self, origin, destination):
        
        url = f"https://maps.googleapis.com/maps/api/directions/json?origin={origin}&destination={destination}&mode=transit&key={self.api_key}"
        response = requests.get(url)
        data = response.json()
        
        if response.status_code == 200:
            data = response.json()
            if data['status'] == 'OK':
                # Extract the arrival time from the response
                route = data['routes'][0]
                leg = route['legs'][0]
                arrival_time = leg['arrival_time']['text']
                return arrival_time
            else:
                raise Exception(f"Error from Google Maps API: {data['status']}")
        else:
            raise Exception(f"HTTP error: {response.status_code}")