import 'dart:convert';
import 'package:transittrack/features/home/data/model/location_model.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

abstract class GoogleMapDatasource {
  Future<List<LocationModel>> getPlacAutoCompleteSuggestion(String input);
  Future<String?> getPlaceIdFromCoordinates(double longitude, double latitude);
  Future<String?> arrivalTimePrediction(
      String? startPlaceId, String? destinationPlaceId);
  Future<Map<String, double>> getLatLngFromPlaceId(String placeId);
}

class GoogleMapDataSourceImpl implements GoogleMapDatasource {
  final http.Client client;

  GoogleMapDataSourceImpl({required this.client});
  final String apiKey = "";

  @override
  Future<List<LocationModel>> getPlacAutoCompleteSuggestion(
      String input) async {
    var uuid = const Uuid();
    String token = uuid.v4();

    final listOfLocations = <LocationModel>[];
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";

    String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
    var response = await http.get(Uri.parse(request));
    print("resssssssssssssssssssss ${response.body}");
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      final result = data['predictions'];

      for (var location in result) {
        listOfLocations.add(LocationModel.fromJson(location));
      }
    } else {
      throw Exception('Failed to load data');
    }
    return listOfLocations;
  }

  @override
  Future<String?> getPlaceIdFromCoordinates(
      double longitude, double latitude) async {
    String baseUrl = "https://maps.googleapis.com/maps/api/geocode/json";

    String request = '$baseUrl?latlng=$latitude,$longitude&key=$apiKey';

    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['results'] != null &&
          responseBody['results'].isNotEmpty) {
        return responseBody['results'][0]['place_id'];
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<String?> arrivalTimePrediction(
      String? startPlaceId, String? destinationPlaceId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&origins=place_id:$startPlaceId&destinations=place_id:$destinationPlaceId&key=$apiKey');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['rows'][0]['elements'][0]['duration_in_traffic']['text'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Map<String, double>> getLatLngFromPlaceId(String placeId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');

    final response = await http.get(url);

      print("rrrrrrrrrrrrrrrrrrrrrrr");
    if (response.statusCode == 200) {
      print("ttttttttttttttttttttttttttttttt");
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];
      return {'latitude': lat, 'longitude': lng};
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
