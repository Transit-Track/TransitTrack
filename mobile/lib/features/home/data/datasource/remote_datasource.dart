import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  Future<List<Prediction>> searchLocation(BuildContext context, String text);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  
  @override
  Future<List<Prediction>> searchLocation(BuildContext context, String? text) async {
    final _predictionList = <Prediction>[];
    if(text != null && text.isNotEmpty) {
    final response = await http.get(
      Uri.parse(
          "http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"),
      headers: {"Content-Type": "application/json"},
    );
      var data = jsonDecode(response.body.toString());
      print('my status is ${data["status"]}');
      if ( data['status']== 'OK') {
        
        data['predictions'].forEach((prediction)
        => _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        // ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}
