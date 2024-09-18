import 'package:equatable/equatable.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';

class StationEntity extends Equatable {
  final String stationId;
  final String name;
  final LocationEntity geoLocation;


  const StationEntity({
    required this.stationId,
    required this.name,
    required this.geoLocation,
  });

  @override
  List<Object> get props => [name, geoLocation, stationId];

  toJson() {}
}
