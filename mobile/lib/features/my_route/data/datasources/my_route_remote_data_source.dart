import 'dart:convert';

import 'package:transittrack/core/constants/constants.dart';
import 'package:transittrack/features/home/data/model/bus_model.dart';
import 'package:http/http.dart' as http;

abstract class MyRouteRemoteDataSource {
  Future<List<BusModel>> getMyRoute();
  Future<String> addBusToMyRoute(String busId);
  Future<String> removeBusFromMyRoute(String busId);
}

class MyRouteRemoteDataSourceImpl implements MyRouteRemoteDataSource {
  final http.Client client;
  MyRouteRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BusModel>> getMyRoute() async {
    final url = Uri.parse('$baseUrl/get_my_route_buses');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> datas = json.decode(response.body);
      final List<BusModel> buses =
          datas.map((bus) => BusModel.fromJson(bus)).toList();
      return buses;
    } else {
      throw Exception('Failed to load buses');
    }
  }

  @override
  Future<String> addBusToMyRoute(String busId) async {
    final url = Uri.parse('$baseUrl/add_bus_to_my_route');
    final response = await client.put(url.replace(queryParameters: {
      'bus_id': busId,
    }));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    if (response.statusCode == 500) {
      throw Exception(json.decode(response.body)['detail']);
    } else {
      throw Exception('Failed to add buses to my route');
    }
  }

  @override
  Future<String> removeBusFromMyRoute(String busId) async {
    final url = Uri.parse('$baseUrl/remove_bus_from_my_route');
    final response = await client.put(url.replace(queryParameters: {
      'bus_id': busId,
    }));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to remove buses from my route');
    }
  }
}
