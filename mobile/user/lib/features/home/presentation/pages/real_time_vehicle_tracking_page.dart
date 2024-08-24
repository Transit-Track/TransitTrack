import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';
import 'package:transittrack/features/home/presentation/widgets/buttom_sheet_content_widget.dart';

class RealTimeVehicleTrackingPage extends StatefulWidget {
  const RealTimeVehicleTrackingPage({super.key});

  @override
  State<RealTimeVehicleTrackingPage> createState() =>
      _RealTimeVehicleTrackingPageState();
}

class _RealTimeVehicleTrackingPageState
    extends State<RealTimeVehicleTrackingPage> {
  LatLng destination = const LatLng(9.0330, 38.7500);
  LatLng currentLocation = LatLng(driver.latitude, driver.longitude);
  LatLng startingPoint = const LatLng(9.0530, 38.7600);
  final PanelController _panelController = PanelController();

  // GoogleDistanceMatrix googleDistanceMatrix = GoogleDistanceMatrix();

  // for the bus icon
  BitmapDescriptor busIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  double remainingDistance = 0.0;
  final Location location = Location();

  //! polylines
  final Set<Marker> markers = {};

  final Set<Polyline> _polyLines = {};
  List<LatLng> polylineCoordinates = [
    const LatLng(9.0330, 38.7500),
    const LatLng(9.0300, 38.7490),
    const LatLng(9.0208, 38.7469),
    const LatLng(9.053, 38.7600),
  ];

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

  void updateLocation(double latitude, double longitude) {
    setState(() {
      currentLocation = LatLng(latitude, longitude);
    });
  }

  @override
  void initState() {
    addCustomMarker();
    updateLocation(driver.latitude, driver.longitude);

   getPolylinepoints();
   
    super.initState();
  }
  
  void getPolylinepoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "",
      request: PolylineRequest(
          origin: PointLatLng(startingPoint.latitude, startingPoint.longitude),
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
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              0.5),
          backgroundColor: Colors.white,
          onPressed: () => {(context).goNamed(AppPath.home)},
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: Stack(
          children: [
            GoogleMap(
              polylines: _polyLines,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                setState(() {});
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('start'),
                  position: startingPoint,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(
                      title: 'start Location',
                      snippet:
                          'Lat: ${startingPoint.latitude}, Lng: ${startingPoint.longitude}'),
                ),
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: destination,
                  icon: busIcon,
                  infoWindow: InfoWindow(
                      title: 'Bus Location',
                      snippet:
                          'Lat: ${currentLocation.latitude}, Lng: ${currentLocation.longitude}'),
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: currentLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(
                      title: 'destination Location',
                      snippet:
                          'Lat: ${destination.latitude}, Lng: ${destination.longitude}'),
                ),
              },
            ),
            SlidingUpPanel(
              controller: _panelController,
              minHeight: 100.h,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              panel: ButtomSheetContentWidget(bus: buses[0]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            ),
          ],
        ));
  }
}
