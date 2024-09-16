import 'package:equatable/equatable.dart';
import 'package:transittrack/features/driver/domain/entity/driver_entity.dart';
import 'package:transittrack/features/home/domain/entities/route_entity.dart';

class BusEntity extends Equatable {
  final String id;
  final String number;
  final String arrivalTime;
  final RouteEntity route;
  final String price;
  final String type;
  final bool isMyRoute;
  final bool isIdle;
  final DriverEntity driver;

  const BusEntity({
    required this.id,
    required this.number,
    required this.arrivalTime,
    required this.price,
    required this.type,
    required this.isMyRoute,
    required this.route,
    this.isIdle = true,
    required this.driver
  });

  @override
  List<Object?> get props => [
        id,
        number,
        arrivalTime,
        price,
        type,
        route,
        isMyRoute,
        isIdle,
        driver
      ];
}
