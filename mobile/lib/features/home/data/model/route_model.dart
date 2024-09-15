import 'package:transittrack/features/home/data/model/station_model.dart';
import 'package:transittrack/features/home/domain/entities/route_entity.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.id,
    required super.distance,
    required super.stations,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['route_id'].toString(),
      distance: json['distance'] ?? 0.0,
      stations: (json['stations'] as List)
          .map((e) => StationModel.fromJson(e))
          .toList() ?? [], 
    ) ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'distance': distance,
      'stations': stations.map((e) => e.toJson()).toList(),
    };
  }
}