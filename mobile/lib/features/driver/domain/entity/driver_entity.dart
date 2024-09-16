import 'package:equatable/equatable.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';

class DriverEntity extends Equatable {
  final String phoneNumber;
  final LocationEntity location;

  const DriverEntity({
    required this.phoneNumber,
    required this.location,
  });
  @override
  List<Object?> get props => [phoneNumber, location];
}
