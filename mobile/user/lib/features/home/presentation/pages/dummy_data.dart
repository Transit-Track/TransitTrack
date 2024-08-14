class Bus {
  final String busNumber;
  final String busType;
  final String arrivalTime;
  final String numberOfStops;
  final String distance;
  final String stationName;

  Bus({
    required this.busNumber,
    required this.busType,
    required this.arrivalTime,
    required this.numberOfStops,
    required this.distance,
    required this.stationName,
  });
}

List<Bus> buses = [
  Bus(busNumber: "23", busType: "Anbesa", arrivalTime: "23min", numberOfStops: "16", distance: "12", stationName: "shola station"),
  Bus(busNumber: "23", busType: "Anbesa", arrivalTime: "23min", numberOfStops: "16", distance: "12", stationName: "shola station"),
  Bus(busNumber: "23", busType: "Anbesa", arrivalTime: "23min", numberOfStops: "16", distance: "12", stationName: "shola station"),
  Bus(busNumber: "23", busType: "Anbesa", arrivalTime: "23min", numberOfStops: "16", distance: "12", stationName: "shola station"),
  Bus(busNumber: "23", busType: "Anbesa", arrivalTime: "23min", numberOfStops: "16", distance: "12", stationName: "shola station")
];
