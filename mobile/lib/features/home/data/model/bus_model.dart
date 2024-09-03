import 'package:transittrack/features/home/domain/entities/bus.dart';

class BusModel extends BusEntity {
  const BusModel({
    required super.arrivalTime,
    required super.distance,
    required super.id,
    required super.destination,
    required super.type,
    required super.latitude,
    required super.longitude,
    required super.number,
    required super.price,
    required super.routes,
    required super.start,
    required super.stationName,
    required super.isMyRoute,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      arrivalTime: json['arrivalTime'],
      distance: json['distance'],
      id: json['id'],
      destination: json['destination'],
      type: json['type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      number: json['number'],
      price: json['price'],
      routes: json['routes'],
      start: json['start'],
      stationName: json['stationName'],
      isMyRoute: json['isMyRoute'] == 'True' ? true : false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrivalTime': arrivalTime,
      'distance': distance,
      'id': id,
      'destination': destination,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'number': number,
      'price': price,
      'routes': routes,
      'start': start,
      'stationName': stationName,
    };
  }
}
