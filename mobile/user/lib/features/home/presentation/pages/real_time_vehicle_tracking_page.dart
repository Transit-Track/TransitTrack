import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';

class RealTimeVehicleTrackingPage extends StatefulWidget {
  const RealTimeVehicleTrackingPage({super.key});

  @override
  State<RealTimeVehicleTrackingPage> createState() =>
      _RealTimeVehicleTrackingPageState();
}

class _RealTimeVehicleTrackingPageState
    extends State<RealTimeVehicleTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(AppPath.home);
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
