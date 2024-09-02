import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final TextEditingController _busNumberController = TextEditingController();
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
                  ButtonWidget(
                    context: context,
                    text: 'Start',
                    onClick: () {},
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
