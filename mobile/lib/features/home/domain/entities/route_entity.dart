import 'package:equatable/equatable.dart';
import 'package:transittrack/features/home/domain/entities/station_entity.dart';

class RouteEntity extends Equatable {
  final String id;
  final List<StationEntity> stations;
  final double distance;

  const RouteEntity({
    required this.id,
    required this.stations,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        stations,
        distance,
      ];

  toJson() {}
}
