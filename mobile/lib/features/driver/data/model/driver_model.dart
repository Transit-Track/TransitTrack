import 'package:transittrack/features/driver/domain/entity/driver_entity.dart';

class DriverModel extends DriverEntity {
  const DriverModel({
    required super.location,
    required super.phoneNumber,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      phoneNumber: json['phoneNumber'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'location': location,
    };
  }
}
