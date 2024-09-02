import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';

class VehicleTrackingMapPage extends StatefulWidget {
  final BusEntity bus;
  const VehicleTrackingMapPage({super.key, required this.bus});

  @override
  State<VehicleTrackingMapPage> createState() => _VehicleTrackingMapPageState();
}

class _VehicleTrackingMapPageState extends State<VehicleTrackingMapPage> {
  BitmapDescriptor busIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  double remainingDistance = 0.0;
  late LatLng driverLocation;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Map<PolylineId, Polyline> polylines = {};
  late List<LatLng> routes = [];

  void addCustomMarker() async {
    ImageConfiguration configuration =
        const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 1);

    BitmapDescriptor.asset(
      configuration,
      'assets/images/anbessa.png',
      width: 50.w,
      height: 50.h,
    ).then((icon) {
      busIcon = icon;
    });
  }

  @override
  void initState() {
    addCustomMarker();
    routes = widget.bus.routes
        .map((e) => LatLng(e['latitude'] as double, e['longitude'] as double))
        .toList();

    routes.sort((a, b) {
      int compareLat = a.latitude.compareTo(b.latitude);
      if (compareLat != 0) {
        return compareLat;
      } else {
        return a.longitude.compareTo(b.longitude);
      }
    });

    generatePolyLineFromPoints(routes);
    driverLocation = const LatLng(9.0350, 38.7800);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: driverLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) =>
                  _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: routes[routes.length - 1],
                zoom: 13,
              ),
              markers: {
                Marker(
                    markerId: const MarkerId('_currentLcation'),
                    position: driverLocation,
                    infoWindow: const InfoWindow(
                      title: 'Google',
                      snippet: 'Googleplex',
                    ),
                    icon: busIcon),
                Marker(
                    markerId: const MarkerId('_startLocation'),
                    position: routes[0],
                    infoWindow: const InfoWindow(
                      title: 'Google',
                      snippet: 'Googleplex',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue)),
                Marker(
                  markerId: const MarkerId('_destinationLcation'),
                  position: routes[routes.length - 1],
                  infoWindow: const InfoWindow(
                    title: 'Google',
                    snippet: 'Googleplex',
                  ),
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: position,
      zoom: 15,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  // Future<void> getLocationUpdate() async {
  //   // Get the current location
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   _serviceEnabled = await locationController.serviceEnabled();
  //   if (_serviceEnabled) {
  //     _serviceEnabled = await locationController.requestService();
  //   } else {
  //     return;
  //   }
  //   _permissionGranted = await locationController.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await locationController.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   locationController.onLocationChanged.listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       // print(currentLocation.latitude);
  //       // print(currentLocation.longitude);
  //       setState(() {
  //         currLocation =
  //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         _cameraToPosition(currLocation!);
  //       });
  //     }
  //   });
  // }

  // Future<List<LatLng>> getPlolyLinePoints() async {
  //   List<LatLng> polylineCoordinates = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   for (int i = 0; i < routes.length - 1; i++) {
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //         googleApiKey: GOOGLE_MAP_API,
  //         request: PolylineRequest(
  //           origin: PointLatLng(routes[i].latitude, routes[i].longitude),
  //           destination:
  //               PointLatLng(routes[i + 1].latitude, routes[i + 1].longitude),
  //           mode: TravelMode.driving,
  //         ));
  //     if (result.points.isNotEmpty) {
  //       result.points.forEach((PointLatLng point) {
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       });
  //     } else {
  //       print(result.errorMessage);
  //     }
  //   }

  //   return polylineCoordinates;
  // }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
