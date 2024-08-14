import 'package:transittrack/features/home/domain/entities/nearby.dart';

class NearByModel extends NearByEntity {
  const NearByModel({
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory NearByModel.fromJson(Map<String, dynamic> json) {
    return NearByModel(
      name: json['name'],
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
    );
  }
}