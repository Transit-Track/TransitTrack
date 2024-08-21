import 'dart:convert';
import 'package:transittrack/features/home/data/model/location_model.dart';
import 'package:transittrack/features/home/data/model/nearby_model.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

abstract class GoogleMapDatasource {
  Future<List<LocationModel>> getPlacAutoCompleteSuggestion(String input);
  Future<List<Bus>> getBuses();
  Future<List<NearByModel>> getNearbyBusStations(
      String input, double longitude, double latitude, double radius);
}

class GoogleMapDataSourceImpl implements GoogleMapDatasource {
  final http.Client client;

  GoogleMapDataSourceImpl({required this.client});

  @override
  Future<List<Bus>> getBuses() {
    // TODO: implement getBuses
    throw UnimplementedError();
  }

  @override
  Future<List<LocationModel>> getPlacAutoCompleteSuggestion(
      String input) async {
    var uuid = Uuid();
    final String apiKey = "";
    String token = uuid.v4();

    final listOfLocations = <LocationModel>[];

    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";

      String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        final result = data['predictions'];

        for (var location in result) {
          listOfLocations.add(LocationModel.fromJson(location));
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
    return listOfLocations;
  }

  Future<List<NearByModel>> getNearbyBusStations(
      String input, double longitude, double latitude, double radius) async {
    List<NearByModel> nearbyBusStations = [];
    const String apiKey = "";
    const String baseUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=cruise&location=-33.8670522%2C151.1957362&radius=1500&type=bus_station&key=$apiKey";

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.displayName',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["results"];
      print('Response data: $data');
      for (var location in data) {
        nearbyBusStations.add(NearByModel.fromJson(location));
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

    return nearbyBusStations;
  }
}
