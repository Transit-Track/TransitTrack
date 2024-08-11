import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String latitude;
  final String longitude;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
      ];
}