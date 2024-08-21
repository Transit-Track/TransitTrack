import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/core/theme.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final Completer<GoogleMapController> _controller = Completer();

  final LatLng start = const LatLng(9.1450, 40.4897);
  final LatLng destination = const LatLng(9.0192, 38.7525);

// devices current location
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];

  // Defin markers
  BitmapDescriptor sourceIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor destinationIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  void getCurentLocation() async {
    Location location = Location();

    location.getLocation().then((value) {
      currentLocation = value;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(cLoc.latitude!, cLoc.longitude!), zoom: 15)));
      setState(() {});
    });
  }

  void setCustomeMarkerItem() {
    BitmapDescriptor.asset(
            const ImageConfiguration(devicePixelRatio: 2.5), "assets/bus.png")
        .then((value) {
      currentIcon = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getPolylinepoints();
    getCurentLocation();
  }

  void getPolylinepoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "",
      request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(destination.latitude, destination.longitude),
          mode: TravelMode.driving),
    );

    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 13),
                polylines: {
                  Polyline(
                      polylineId: const PolylineId("route"),
                      color: primary,
                      points: polylineCoordinates,
                      width: 6)
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("source"),
                    position: start,
                    icon: sourceIcon,
                  ),
                  Marker(
                    markerId: const MarkerId("destination"),
                    position: destination,
                    icon: destinationIcon,
                  ),
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    icon: currentIcon,
                  ),
                },

                // make the camera location change based on the location of the device
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ));
  }
}
