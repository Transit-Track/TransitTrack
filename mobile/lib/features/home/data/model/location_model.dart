import 'package:transittrack/features/home/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
