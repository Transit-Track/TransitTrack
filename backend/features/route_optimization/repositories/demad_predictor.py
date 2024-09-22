import numpy as np
from keras.models import load_model
from datetime import datetime

class DemandPredictor:
    def __init__(self, model_path):
        self.model = load_model(model_path='')
        self.column_mapping = {
            'timestamp': '1001',
            'day_of_week': '1002',
            'hour_of_day': '1003',
            'start_station': '1004',
            'destination_station': '1005',
            'is_weekday': '1006',
            'is_holiday': '1007',
            'demand': '1008'
        }
        self.et_holidays = [
    '2024-09-11', '2024-09-12', '2024-01-06', '2024-01-07',
    '2024-01-19', '2024-01-20', '2024-01-07', '2024-05-28',
    '2024-06-09', '2024-05-02'
]

    def prepare_input_data(self, start_station, destination_station):
        now = datetime.now()
        timestamp = int(now.timestamp())
        day_of_week = now.weekday()  # Monday is 0 and Sunday is 6
        hour_of_day = now.hour
        is_weekday = 1 if day_of_week < 5 else 0
        is_holiday = 1 if now in self.et_holidays else 0

        input_data = {
            'timestamp': timestamp,
            'day_of_week': day_of_week,
            'hour_of_day': hour_of_day,
            'start_station': start_station,
            'destination_station': destination_station,
            'is_weekday': is_weekday,
            'is_holiday': is_holiday
        }
        
        # Create a numpy array in the correct order
        input_array = np.array([[input_data['timestamp'],
                                 input_data['day_of_week'],
                                 input_data['hour_of_day'],
                                 input_data['start_station'],
                                 input_data['destination_station'],
                                 input_data['is_weekday'],
                                 input_data['is_holiday']]])
        
        return input_array

    def predict_demand(self, start_station, destination_station):
        # Prepare the input data for the model
        input_array = self.prepare_input_data(start_station, destination_station)
        # Make the prediction
        predicted_demand = self.model.predict(input_array)
        return predicted_demand[0][0]

    def calculate_demand_satisfied(self, route_info, bus_capacity):
        total_demand_satisfied = 0
        current_capacity = bus_capacity
        current_passengers = []
        stations = route_info['stations']
        
        for i in range(len(stations) - 1):
            start_station = stations[i]
            destination_station = stations[i + 1]
            
            # Update capacity as passengers get off at their destinations
            current_passengers = [p for p in current_passengers if p != start_station]
            current_capacity = bus_capacity - len(current_passengers)
            
            # Predict the demand between the two stations at the current time
            demand = self.predict_demand(start_station, destination_station)
            
            # Calculate the demand satisfied by the bus
            if demand <= current_capacity:
                total_demand_satisfied += demand
                current_capacity -= demand
                current_passengers.extend([destination_station] * int(demand))
            else:
                total_demand_satisfied += current_capacity
                current_passengers.extend([destination_station] * int(current_capacity))
                current_capacity = 0
        
        
        return total_demand_satisfied