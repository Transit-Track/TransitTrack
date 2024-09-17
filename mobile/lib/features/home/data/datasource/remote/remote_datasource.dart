import 'dart:convert';

import 'package:transittrack/core/constants/constants.dart';
import 'package:transittrack/features/driver/data/model/driver_location_model.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/model/bus_model.dart';
import 'package:http/http.dart' as http;
import 'package:transittrack/features/home/data/model/place_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<BusModel>> getAvailablebuses(
      String startLocation, String destinationLocation);
  Future<List<String>> getNearbyBusStations(String input);
  Future<LocationModel> getDriverLocation(String driverPhoneNumber);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;
  final GoogleMapDatasource googleMapDatasource;

  HomeRemoteDataSourceImpl({
    required this.client,
    required this.googleMapDatasource,
  });

  @override
  Future<List<BusModel>> getAvailablebuses(
      String startLocation, String destinationLocation) async {
    final url = Uri.parse('$baseUrl/search_bus_by_route');

    final queryParams = {
      'start_station': startLocation,
      'end_station': destinationLocation,
    };

    final response =
        await client.get(url.replace(queryParameters: queryParams));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<BusModel> buses =
          data.map((json) => BusModel.fromJson(json)).toList();
      return buses;
    } else {
      throw Exception('Failed to load buses');
    }
  }

  @override
  Future<List<String>> getNearbyBusStations(String input) async {
    List<String> nearbyBusStations = [];
    List<Map<String, dynamic>> locationslatlng = [];
    const double radius = 100;

    final availableSuggestions =
        await googleMapDatasource.getPlacAutoCompleteSuggestion(input);
    for (PlaceModel location in availableSuggestions) {
      final latlng =
          await googleMapDatasource.getLatLngFromPlaceId(location.id);
      locationslatlng.add(latlng);
    }

    final url = Uri.parse('$baseUrl/stations');
    final requestBody = {
      'locations': locationslatlng,
      'radius': radius,
    };

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      nearbyBusStations = data.map((json) => json["name"].toString()).toList();
    } else {
      throw Exception('Failed to load nearby bus stations');
    }
    return nearbyBusStations;
  }

  @override
  Future<LocationModel> getDriverLocation(
      String driverPhoneNumber) async {
    final url = Uri.parse('$baseUrl/driver');
    final Map<String, dynamic> queryParam = {"phone_number": driverPhoneNumber};

    final response = await client.get(url.replace(queryParameters: queryParam));
    if (response.statusCode == 200) {
     
      return LocationModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return json.decode(response.body)["detail"];
    } else {
      throw Exception("Failed to load drivers lovation");
    }
  }
}
