import 'package:equatable/equatable.dart';

class NearByEntity extends Equatable {
  final String name;
  final double latitude;
  final double longitude;

  const NearByEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
  
  @override
  List<Object?> get props => [name, latitude, longitude];
}
