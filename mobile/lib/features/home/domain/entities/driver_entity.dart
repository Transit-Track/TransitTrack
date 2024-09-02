import 'package:equatable/equatable.dart';

class DriverEntity extends Equatable {
  final double longitude;
  final double latitude;

  const DriverEntity({
    required this.longitude,
    required this.latitude,
  });
  @override
  List<Object?> get props => [longitude, latitude];
}
