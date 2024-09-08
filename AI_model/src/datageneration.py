import pandas as pd
import numpy as np
import random

# Generate random timestamps
timestamps = pd.date_range(start='2024-01-01', end='2024-10-30', freq='h')

# List of destination stations and their numeric mappings
start_station = "Megenagna"
start_mapping = {"Megenagna": 0}
destination_stations = ["4 kilo", "Bole", "Piassa", "Mexico"]
destination_mapping = {"4 kilo": 3, "Bole": 2, "Piassa": 1, "Mexico": 4}

# List of Ethiopian holiday dates
holidays = [
    '2024-09-11', '2024-09-12', '2024-01-06', '2024-01-07', 
    '2024-01-19', '2024-01-20', '2024-01-07', '2024-05-28', 
    '2024-06-09', '2024-05-02'
]

# List of dates with high demand considering churches on the route
high_demand_days = [
    '2024-05-20', '2024-07-20', '2024-08-20', '2024-05-30', '2024-03-30'
]

# List of high-demand times based on data analysis
high_demand_times = [
    '07:00:00', '08:00:00', '09:00:00', '09:30:00', 
    '15:00:00', '16:00:00', '17:00:00', '18:00:00'
]

# Convert high-demand days to timestamps
high_demand_timestamps = []
for day in high_demand_days:
    for time in high_demand_times:
        high_demand_timestamps.append(pd.Timestamp(f"{day} {time}"))

# Combine regular timestamps with high-demand timestamps
timestamps = timestamps.append(pd.DatetimeIndex(high_demand_timestamps)).drop_duplicates().sort_values()

# Ensure holidays are included in the timestamps
holiday_timestamps = pd.to_datetime(holidays)
timestamps = timestamps.append(holiday_timestamps).drop_duplicates().sort_values()

# Create a DataFrame with temporal and spatial features
data = pd.DataFrame({
    'timestamp': timestamps,
    'day_of_week': timestamps.strftime('%A').map({
        'Monday': 0, 'Tuesday': 1, 'Wednesday': 2, 'Thursday': 3, 'Friday': 4, 'Saturday': 5, 'Sunday': 6
    }), 
    'hour_of_day': timestamps.hour,
    'start_station': 0,  
    'destination_station': np.random.choice([3, 2, 1, 4], size=len(timestamps)),  
    'is_weekday': (timestamps.weekday < 5).astype(int), 
    'is_holiday': (timestamps.strftime('%Y-%m-%d').isin(holidays) | timestamps.strftime('%Y-%m-%d').isin(high_demand_days)).astype(int)  
})

# Adjust high demand routes for specific days
data.loc[data['timestamp'].dt.strftime('%Y-%m-%d').isin(high_demand_days) & (data['timestamp'].dt.day == 20), 'destination_station'] = 2  # Bole
data.loc[data['timestamp'].dt.strftime('%Y-%m-%d').isin(high_demand_days) & (data['timestamp'].dt.day == 30), 'destination_station'] = 3  # 4 kilo

# Generate random demand based on features
data['demand'] = data['day_of_week'] * 10 + data['hour_of_day'] * 5 + data['is_weekday'] * 20 + data['is_holiday'] * 50 + np.random.randint(0, 20, size=len(timestamps))

# Adjust demand for high-demand days
data.loc[data['timestamp'].dt.strftime('%Y-%m-%d').isin(high_demand_days), 'demand'] += 50

# Adjust demand for official holidays to be low
data.loc[data['is_holiday'] & ~data['timestamp'].dt.strftime('%Y-%m-%d').isin(high_demand_days), 'demand'] -= 30

# Adjust demand for specific high-demand times
for time in high_demand_times:
    data.loc[data['timestamp'].dt.strftime('%H:%M:%S') == time, 'demand'] += 50

# Map column names to four-digit unique numbers
column_mapping = {
    'timestamp': '1001',
    'day_of_week': '1002',
    'hour_of_day': '1003',
    'start_station': '1004',
    'destination_station': '1005',
    'is_weekday': '1006',
    'is_holiday': '1007',
    'demand': '1008'
}

# Rename columns
data.rename(columns=column_mapping, inplace=True)

data.to_csv('commuter_demand.csv', index=False)