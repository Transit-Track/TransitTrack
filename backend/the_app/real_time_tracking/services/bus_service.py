from real_time_tracking.repositories.bus_repo import BusRepository

class BusService:
    def __init__(self, repo: BusRepository):
        self.repo = repo

    
    def search_bus_by_route(self, start_station, end_station):
        return self.repo.search_bus_by_route(start_station, end_station)
    
    
    