import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class HomeLocalDataSource {
  Future<void> saveStationNames(List<String> stationNames);

  Future<List<String>> getStationNames();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final FlutterSecureStorage secureStorage;

  HomeLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<List<String>> getStationNames() async {
    final stationNamesJson = await secureStorage.read(key: 'station_names');
    if (stationNamesJson != null) {
      List<dynamic> stationNamesList = json.decode(stationNamesJson);
      return stationNamesList.cast<String>();
    }
    return [];
  }

  @override
  Future<void> saveStationNames(List<String> stationNames) async {
    final stationNamesJson = json.encode(stationNames);
    await secureStorage.write(key: 'station_names', value: stationNamesJson);
  }
}
