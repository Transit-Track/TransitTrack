import 'package:transittrack/features/home/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.name,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['place_id'],
      name: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
