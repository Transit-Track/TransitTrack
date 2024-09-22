import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';

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
  LatLng? driverLocation;

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

  void initializeDriverLocation(
      BuildContext context, String driverPhoneNumber) {
    BlocProvider.of<HomeBloc>(context)
        .add(GetDriverLocation(driverPhoneNumber: driverPhoneNumber));
  }

  @override
  void initState() {
    addCustomMarker();
    routes = widget.bus.route.stations
        .map((e) => LatLng(e.geoLocation.latitude, e.geoLocation.longitude))
        .toList();

    routes.sort((a, b) {
      int compareLat = a.latitude.compareTo(b.latitude);
      if (compareLat != 0) {
        return compareLat;
      } else {
        return a.longitude.compareTo(b.longitude);
      }
    });
    // driverLocation = routes[0];
    generatePolyLineFromPoints(routes);
    super.initState();
    initializeDriverLocation(context, '251912457812');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetDriverLocationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: white,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is GetDriverLocationErrorState) {
              return  Center(
                child: Text(state.errorMessage),
              );
            } else if (state is GetDriverLocationLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetDriverLocationLoadedState) {
              driverLocation = LatLng(state.driverLocationEntity.latitude,
                  state.driverLocationEntity.longitude);
              return driverLocation == null
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
                          markerId: const MarkerId('_currentLocation'),
                          position: driverLocation!,
                          infoWindow: const InfoWindow(
                            title: 'Google',
                            snippet: 'Googleplex',
                          ),
                          icon: busIcon,
                        ),
                        Marker(
                          markerId: const MarkerId('_startLocation'),
                          position: routes[0],
                          infoWindow: const InfoWindow(
                            title: 'Google',
                            snippet: 'Googleplex',
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                        ),
                        Marker(
                          markerId: const MarkerId('_destinationLocation'),
                          position: routes[routes.length - 1],
                          infoWindow: const InfoWindow(
                            title: 'Google',
                            snippet: 'Googleplex',
                          ),
                        ),
                      },
                      polylines: Set<Polyline>.of(polylines.values),
                    );
            } else {
              return const Center(
                child: Text('Unknown Error'),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 15,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

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
