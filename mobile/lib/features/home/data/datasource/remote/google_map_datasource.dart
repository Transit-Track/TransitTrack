import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:transittrack/env/env.dart';
import 'package:transittrack/features/home/data/model/location_model.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:http/http.dart' as http;

abstract class GoogleMapDatasource {
  Future<List<LocationModel>> getPlacAutoCompleteSuggestion(String input);
  Future<List<Bus>> getBuses();
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
    final String apiKey = Env.googleApiKey;
    const String token = "1234567890";

    final listOfLocations = <LocationModel>[];

    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";

      String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final result = json.decode(response.body)['data']['predictions'];
        print(result);
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
}
