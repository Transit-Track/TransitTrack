import 'package:equatable/equatable.dart';

class DriverLocationEntity extends Equatable {
  final double longitude;
  final double latitude;

  const DriverLocationEntity({
    required this.longitude,
    required this.latitude,
  });
  @override
  List<Object?> get props => [longitude, latitude];
}
