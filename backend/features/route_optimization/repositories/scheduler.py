from features.route_optimization.repositories.demad_predictor import DemandPredictor
from features.route_optimization.repositories.route_opt_repo import RouteOptRepo
import random

from features.route_optimization.repositories.traffic_status import GoogleMapsAPI


class Scheduler:
    def __init__(self) -> None:
        self.schedule = {}
        self.routes = {}
        self.idle_buses = {}
        self.repo = RouteOptRepo()
        self.google_maps_api = GoogleMapsAPI()
        self.demand_predictor = DemandPredictor()
    
    def idle_buses(self):
        buses =  self.repo.get_idle_buses()
        self.idle_buses = {bus['bus_id']:bus for bus in buses}
        # return self.idle_buses
    def get_routes(self):
        routes = self.repo.get_all_routes()
        self.routes = {route['route_id']:route for route in routes}
        # return self.routes
        
    def initial_population(self):
        self.idle_buses()
        self.get_routes()
        
        buses = self.idle_buses.keys()
        routes = self.routes.keys()
        
        population = []
        while len(population) < 500:
            random.shuffle(buses)
            random.shuffle(routes)
            
            chromosome = {}
            for i in range(min(len(buses), len(routes))):
                chromosome[buses[i]] = routes[i]
            
            population.append(chromosome)
        
        return population
            
    
    def fitness(self, individual):
        total_demand_satisfied = 0
        total_time_spent = 0
        
        for bus_id, route_id in individual.items():
            route_info = self.routes[route_id]
            bus_capacity = self.idle_buses[bus_id]['capacity']
            
            # Calculate the demand satisfied using the DemandPredictor
            demand_satisfied = self.demand_predictor.calculate_demand_satisfied(route_info, bus_capacity)
            total_demand_satisfied += demand_satisfied
                        
            # Calculate the time spent using Google Maps API
            total_time_spent += self.google_maps_api.get_arrival_time_through_waypoints(route_info['stations'])
            
            # Calculate the arrival time to the start station
            latitude = self.idle_buses[bus_id]['driver']['location']['latitude']
            longitude = self.idle_buses[bus_id]['driver']['location']['longitude']
            origin, destination = f"{latitude},{longitude}", route_info['stations'][0]['name']
            arrival_time = self.google_maps_api.general_arrival_time(origin, destination)
            total_time_spent += arrival_time
        
        # Fitness is demand satisfied minus time spent
        fitness_value = total_demand_satisfied - total_time_spent
        
        return fitness_value
    
    def crossover(self, parent1, parent2):
        # Get the list of bus IDs
        bus_ids = list(parent1.keys())
        
        # Choose a random crossover point
        crossover_point = random.randint(1, len(bus_ids) - 1)
        
        # Create the child chromosome
        child = {}
        
        # Combine parts of the parents
        for i in range(crossover_point):
            bus_id = bus_ids[i]
            child[bus_id] = parent1[bus_id]
        
        for i in range(crossover_point, len(bus_ids)):
            bus_id = bus_ids[i]
            child[bus_id] = parent2[bus_id]
        
        return child

    def mutate(self, chromosome):
        # Get the list of bus IDs and route IDs
        bus_ids = list(chromosome.keys())
        route_ids = list(self.routes.keys())
        
        # Choose a random bus to mutate
        bus_to_mutate = random.choice(bus_ids)
        
        # Choose a new random route for this bus
        new_route = random.choice(route_ids)
        
        # Mutate the chromosome
        chromosome[bus_to_mutate] = new_route
        
        return chromosome
    
    def genetic_algorithm(self, generations=100):
        
        initial_pop = self.initial_population()
        for generation in range(generations):
            # Evaluate the fitness of the population
            initial_pop.sort(key=self.fitness, reverse=True)
            
            # Determine the number of top individuals to select (10% of the population)
            top_10_percent_count = max(1, len(initial_pop) // 10)
            
            # Select the top 10% of the population
            top_individuals = initial_pop[:top_10_percent_count]
            
            next_population = []
            
            # Generate the next population
            while len(next_population) < len(initial_pop):
                parent1 = random.choice(top_individuals)
                parent2 = random.choice(top_individuals)
                
                # Perform crossover and mutation to create a new individual
                child = self.crossover(parent1, parent2)
                child = self.mutate(child)
                
                next_population.append(child)
            
            # Replace the old population with the new population
            initial_pop = next_population
        
        # Sort the final population based on fitness
        initial_pop.sort(key=self.fitness, reverse=True)
        self.schedule = initial_pop[0]
        # Return the most fit individual of the final population
        # return self.schedule