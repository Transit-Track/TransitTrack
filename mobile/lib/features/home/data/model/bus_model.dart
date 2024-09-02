import 'package:transittrack/features/home/domain/entities/bus.dart';

class BusModel extends BusEntity {
  const BusModel({
    required super.arrivalTime,
    required super.distance,
    required super.id,
    required super.destination,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
    required super.number,
    required super.price,
    required super.routes,
    required super.start,
    required super.stationName,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      arrivalTime: json['arrivalTime'],
      distance: json['distance'],
      id: json['id'],
      destination: json['destination'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      number: json['number'],
      price: json['price'],
      routes: json['routes'],
      start: json['start'],
      stationName: json['stationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrivalTime': arrivalTime,
      'distance': distance,
      'id': id,
      'destination': destination,
      'imageUrl': imageUrl,
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
