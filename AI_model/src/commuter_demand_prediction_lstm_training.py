import pandas as pd
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, Input
from sklearn.preprocessing import MinMaxScaler

# Load the data
data = pd.read_csv('commuter_demand.csv')

data.fillna(0, inplace=True)  # Handle missing values by filling with 0

# Normalize the features
scaler = MinMaxScaler()
scaled_data = scaler.fit_transform(data[['1002', '1003', '1004', '1005', '1006', '1007', '1008']])

# Create input sequences
def create_sequences(data, seq_length):
    X = []
    y = []
    for i in range(len(data) - seq_length - 1):
        seq = data[i:i+seq_length]
        label = data[i+seq_length, -1]
        X.append(seq)
        y.append(label)
    return np.array(X), np.array(y)

seq_length = 24
X, y = create_sequences(scaled_data, seq_length)

# Split data into training and testing sets
train_size = int(len(X) * 0.8)
X_train, X_test = X[:train_size], X[train_size:]
y_train, y_test = y[:train_size], y[train_size:]

# Create the LSTM model
model = Sequential()
model.add(Input(shape=(seq_length, X_train.shape[2])))
model.add(LSTM(units=50, return_sequences=True))
model.add(LSTM(units=50))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mean_squared_error')

# Train the model
model.fit(X_train, y_train, epochs=10, batch_size=32, validation_data=(X_test, y_test))

# Make predictions
predictions = model.predict(X_test)

