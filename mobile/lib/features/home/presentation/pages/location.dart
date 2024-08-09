import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/env/env.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Location _locatioinOntroller = new Location();
  Map<PolylineId, Polyline> polyLines = {};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _start = LatLng(19.0167464, 38.8962306);
  static const LatLng _destination = LatLng(5.0167464, 38.8962306);
  LatLng? _currPos = null;

  @override
  void initState() {
    super.initState();
    getPolyLinePoints();
    (_) => {
          getLocationUpdates().then(
            (_) => {
              getPolyLinePoints().then((List<LatLng> polylineCoordinates) => {
                    generatePolyLineFromPoints(polylineCoordinates),
                  }),
            },
          )
        };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      // body: _currPos == null
      //     ? Center(child: Text('Loading ... '))
      //     :
          body: GoogleMap(
            onMapCreated: (GoogleMapController controller) =>
                _mapController.complete(controller),
            initialCameraPosition: CameraPosition(target: _start, zoom: 10),
            markers: {
              // Marker(
              //     markerId: MarkerId('_currentLocation'),
              //     position: _currPos!,
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueBlue)),
              Marker(
                  markerId: MarkerId('start'),
                  position: _start,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen)),
              Marker(
                  markerId: MarkerId('destination'),
                  position: _destination,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed)),
            },
            polylines: Set<Polyline>.of(polyLines.values),
          ),
        );
      }

      Future<void> cameraToPosition(LatLng pos) async {
        final GoogleMapController controller = await _mapController.future;
        CameraPosition _cameraPosition = CameraPosition(target: pos, zoom: 10);
        controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
      }

      Future<void> getLocationUpdates() async {
        bool _serviceEnabled;
        PermissionStatus _permissionGranted;

        _serviceEnabled = await _locatioinOntroller.serviceEnabled();
        if (_serviceEnabled) {
          _serviceEnabled = await _locatioinOntroller.requestService();
        } else {
          return;
        }

        _permissionGranted = await _locatioinOntroller.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await _locatioinOntroller.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        _locatioinOntroller.onLocationChanged
            .listen((LocationData currentLocation) {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            setState(() {
              _currPos =
                  LatLng(currentLocation.latitude!, currentLocation.longitude!);
            });
          }
          cameraToPosition(_currPos!);
          print(_currPos);
          print(currentLocation.latitude);
          print(currentLocation.longitude);
        });
      }

      Future<List<LatLng>> getPolyLinePoints() async {
        List<LatLng> polylineCoordinates = [];
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            googleApiKey: Env.googleApiKey,
            request: PolylineRequest(
                destination:
                    PointLatLng(_destination.latitude, _destination.longitude),
                origin: PointLatLng(_start.latitude, _start.longitude),
                mode: TravelMode.driving));

        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        } else {
          print(result.errorMessage);
        }

        return polylineCoordinates;
      }

      void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.red,
            points: polylineCoordinates,
            width: 3);
        setState(() {
          polyLines[id] = polyline;
        });
  }

}
