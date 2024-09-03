import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';
import 'package:transittrack/features/home/presentation/widgets/card_widget.dart';

class MyRoute extends StatefulWidget {
  const MyRoute({super.key});

  @override
  State<MyRoute> createState() => _MyRouteState();
}

class _MyRouteState extends State<MyRoute> {
  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    startController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height:
                        20.h), // Spacing between the input section and tickets
                Text(
                  "My routes",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: secondary
                  ),
                ),
                SizedBox(height: 16.h),
                // The ticket list area
                Expanded(
                  child: ListView.builder(
                    itemCount: myRoutes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: InkWell(
                          onTap: () {
                            (context).goNamed(AppPath.realTimeVehicleTracking,
                                extra: {
                                  "bus": myRoutes[index],
                                });
                          },
                          child: CardWidget(bus: myRoutes[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
