import 'package:transittrack/features/driver/data/model/driver_location_model.dart';
import 'package:transittrack/features/home/data/model/route_model.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/driver/domain/entity/driver_entity.dart';

class BusModel extends BusEntity {
  const BusModel({
    required super.arrivalTime,
    required super.id,
    required super.type,
    required super.number,
    required super.price,
    required super.isMyRoute,
    required super.driver,
    required super.route,
    super.isIdle,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      arrivalTime: json['arrivalTime'].toString(),
      id: json['_id'].toString(),
      type: json['bus_type'].toString(),
      number: json['bus_id'].toString(),
      price: json['price'].toDouble(),
      isMyRoute: json['is_my_route'] ?? false,
      driver: DriverEntity(
          phoneNumber: json['driver']['phone_number'].toString(),
          location: LocationModel(
              longitude: json['driver']['location']['longitude'] ?? 0.0,
              latitude: json['driver']['location']['latitude'] ?? 0.0)),
      route: RouteModel.fromJson(
        json['route'] ??
            const RouteModel(
              id: 'id',
              distance: 9,
              stations: [],
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrivalTime': arrivalTime,
      'id': id,
      'type': type,
      'number': number,
      'price': price,
      'route': route.toJson(),
      'isMyRoute': isMyRoute,
      'driver': {
        'phoneNumber': driver.phoneNumber,
        'location': {
          'longitude': driver.location.longitude,
          'latitude': driver.location.latitude
        }
      }
    };
  }

  factory BusModel.fromEntity(BusEntity entity) {
    return BusModel(
        route: entity.route,
        arrivalTime: entity.arrivalTime,
        id: entity.id,
        type: entity.type,
        number: entity.number,
        price: entity.price,
        isMyRoute: entity.isMyRoute,
        driver: entity.driver);
  }
}
