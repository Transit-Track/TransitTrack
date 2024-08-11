import 'package:equatable/equatable.dart';

class Bus extends Equatable {
  final String id;
  final String number;
  final List<String> routes;
  final String location;
  final String start;
  final String destination;
  final String time;
  final String price;

  const Bus({
    required this.id,
    required this.number,
    required this.routes,
    required this.location,
    required this.start,
    required this.destination,
    required this.time,
    required this.price,
  });
  
  @override
  List<Object?> get props => [
        id,
        number,
        routes,
        location,
        start,
        destination,
        time,
        price,
      ];
}
