import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';
import 'package:transittrack/features/home/domain/entities/driver_entity.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final TextEditingController _busNumberController = TextEditingController();
  bool trackingStarted = false;
  final Location location = Location();


  Future<void> getLocationPermission() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void startBusLocationTracking() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      startOrUpdateLocation(
          currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });

    location.enableBackgroundMode(enable: true);
  }

  void startOrUpdateLocation(double latitude, double longitude) {
    setState(() {
      driver = DriverEntity(
        latitude: latitude,
        longitude: longitude,
      );
      driverLocation = LatLng(latitude, longitude);
    });
  }

  @override
  void initState() {
    getLocationPermission();
    driver = const DriverEntity(
      latitude: 9.0208,
      longitude: 38.7469,
    );
    driverLocation = LatLng(driver.latitude, driver.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.w, 20.h, 0.w, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/driverlocation.jpeg',
                    width: MediaQuery.of(context).size.width,
                    height: 200.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 35.w),
                    child: const Text(
                      textAlign: TextAlign.center,
                      '👋 Hello There\n',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 87, 86, 86),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 80.w),
                    child: InputFieldWidget(
                      controller: _busNumberController,
                      validation: null,
                      keyboardType: TextInputType.number,
                      hintText: 'Bus Number',
                      context: context,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  trackingStarted ? ButtonWidget(
                    context: context,
                    text: 'Cancel',
                    color: danger,
                    onClick: () {
                      trackingStarted = false;
                    },
                  ) : ButtonWidget(
                    context: context,
                    text: 'Start',
                    color: success,
                    onClick: () {
                      trackingStarted = true;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  const Text(
                    'Next Route',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Color.fromARGB(255, 209, 209, 209),
                  //       ),
                  //       borderRadius: BorderRadius.circular(100)),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 25.0.w, vertical: 13.h),
                  //     child: const Text(
                  //       textAlign: TextAlign.center,
                  //       'from mexico to megenagna',
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
