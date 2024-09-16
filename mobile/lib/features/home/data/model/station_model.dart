import 'package:transittrack/features/driver/data/model/driver_location_model.dart';
import 'package:transittrack/features/home/domain/entities/station_entity.dart';

class StationModel extends StationEntity {
  const StationModel({
    required super.stationId,
    required super.name,
    required super.geoLocation,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      stationId: json['station_id'].toString(),
      name: json['name'] ?? '',
      geoLocation: LocationModel.fromJson(json['geoLocation']) ??
          LocationModel(latitude: 0.0, longitude: 0.0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'station_id': stationId,
      'name': name,
      'geo_location': geoLocation.toJson(),
    };
  }
}
