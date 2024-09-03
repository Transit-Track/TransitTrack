import 'package:equatable/equatable.dart';

class BusEntity extends Equatable {
  final String id;
  final String number;
  final List<Map<String, dynamic>> routes;
  final String longitude;
  final String latitude;
  final String start;
  final String destination;
  final String arrivalTime;
  final String price;
  final String stationName;
  final String distance;
  final String type;
  final bool isMyRoute;

  const BusEntity({
    required this.id,
    required this.number,
    required this.routes,
    required this.longitude,
    required this.latitude,
    required this.start,
    required this.destination,
    required this.arrivalTime,
    required this.price,
    required this.stationName,
    required this.type,
    required this.isMyRoute,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        routes,
        longitude,
        latitude,
        start,
        destination,
        arrivalTime,
        price,
        type,
        isMyRoute,
        stationName,
        distance,
      ];
}
