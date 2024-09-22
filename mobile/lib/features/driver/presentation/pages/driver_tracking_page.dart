import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_dialog_box_widget.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transittrack/features/driver/presentation/bloc/driver_bloc.dart';

class DriverTrackingPage extends StatefulWidget {
  const DriverTrackingPage({super.key});

  @override
  State<DriverTrackingPage> createState() => _DriverTrackingPageState();
}

class _DriverTrackingPageState extends State<DriverTrackingPage> {
  // final TextEditingController _busNumberController = TextEditingController();
  final Location locationController = Location();
  bool isTrackerOn = false;

  Future<void> updateLocation(BuildContext context) async {
    // Get the current location
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
       
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          // call a bloc to Update the driver's location
          (context).read<DriverBloc>().add(
                UpdateDriverLocationEvent(
                  latitude: currentLocation.latitude!,
                  longitude: currentLocation.longitude!,
                ),
              );
        }
      }
    });
  }

  void stopTracking() {
    // Stop tracking
  }

  Future<void> _showStartCustomDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => const CustomDialogBoxWidget(
        text: 'Are you sure you want to start tracking?',
      ),
    );

    if (result != null && result == true) {
      // Start tracking
      setState(() {
        isTrackerOn = true;
      });
    }
  }

  Future<void> _showCancelCustomDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => const CustomDialogBoxWidget(
        text: 'Are you sure you want to stop tracking?',
      ),
    );

    if (result != null && result == true) {
      // Start tracking
      stopTracking();
      setState(() {
        isTrackerOn = false;
      });
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    (context).read<AuthenticationBloc>().add(LogoutEvent());
                    (context).goNamed(AppPath.login);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.logout,
                            size: 30,
                            color: secondary,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: secondary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/driverlocationtracking.jpeg',
                  width: MediaQuery.of(context).size.width,
                  height: 250.h,
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '👋 Hello There\n',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: secondary,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Press start to begin tracking',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: secondary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(vertical: 1.0, horizontal: 80.w),
                //   child: InputFieldWidget(
                //     controller: _busNumberController,
                //     validation: null,
                //     keyboardType: TextInputType.number,
                //     hintText: 'Bus Number',
                //     context: context,
                //   ),
                // ),
                // SizedBox(
                //   height: 12.h,
                // ),
                isTrackerOn
                    ? Center(
                        child: ButtonWidget(
                          context: context,
                          text: 'Cancel',
                          onClick: () {
                            _showCancelCustomDialog(context);
                          },
                          color: success,
                        ),
                      )
                    : Center(
                        child: ButtonWidget(
                          context: context,
                          text: 'Start',
                          onClick: () {
                            updateLocation(context);

                            _showStartCustomDialog(context);
                            if (isTrackerOn) {
                              // getLocationUpdate(context);
                            }
                          },
                          color: primary,
                        ),
                      ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 0.h, 0.w, 0.h),
                  child: const Text(
                    'Next Route',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
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
      ),
    );
  }
}
