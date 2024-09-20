import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/presentation/widgets/vehicle_tracking_map_page.dart';
import 'package:transittrack/features/home/presentation/widgets/buttom_sheet_content_widget.dart';

class RealTimeVehicleTrackingPage extends StatefulWidget {
  final BusEntity bus;

  const RealTimeVehicleTrackingPage({
    super.key,
    required this.bus,
  });

  @override
  State<RealTimeVehicleTrackingPage> createState() =>
      _RealTimeVehicleTrackingPageState();
}

class _RealTimeVehicleTrackingPageState
    extends State<RealTimeVehicleTrackingPage> {
  
  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
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
          onPressed: () => {
            (context).pop()
            },
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: Stack(
          children: [
            VehicleTrackingMapPage(bus: widget.bus),
            SlidingUpPanel(
              controller: _panelController,
              minHeight: 100.h,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              panel: ButtomSheetContentWidget(bus: widget.bus),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(50)),
            ),
          ],
        ));
  }
}
