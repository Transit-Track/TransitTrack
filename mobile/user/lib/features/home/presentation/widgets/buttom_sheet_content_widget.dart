import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';

class ButtomSheetContentWidget extends StatefulWidget {
  const ButtomSheetContentWidget({super.key});

  @override
  State<ButtomSheetContentWidget> createState() =>
      _ButtomSheetContentWidgetState();
}

class _ButtomSheetContentWidgetState extends State<ButtomSheetContentWidget> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Center(
              child: Container(
                width: 55.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/anbessa.png',
                    width: 100.w,
                    height: 80.h,
                  ),
                  Text('Anbessa Bus', style: TextStyle(fontSize: 10.sp)),
                ],
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mexico --> Shiro Meda',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '01',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(width: 125.w),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/time.png',
                              width: 30.w,
                              height: 30.h,
                            ),
                            Text('45 min')
                          ],
                        )
                      ],
                    ),
                    Text('10 stops'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              collapsableRoutesWidget(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 2.w, 25.h),
                child: ButtonWidget(
                    context: context,
                    height: 50.h,
                    width: 100.w,
                    text: 'Buy',
                    onClick: () {
                      (context).goNamed(AppPath.payment);
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget collapsableRoutesWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 38.0.w),
                  child: Row(
                    children: [
                      Text("Start", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 12.w),
                      const Icon(
                        Icons.navigation,
                        color:
                            Colors.green, // Replace with your 'success' color
                      ),
                      Container(
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Colors
                                  .grey), // Replace with your 'secondary' color
                        ),
                        child: Center(child: Text('Station $index')),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(300),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isCollapsed = !_isCollapsed;
                            });
                          },
                          child: const Center(
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (index == 14) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 5.0.w),
                  child: Row(
                    children: [
                      Text("Destination", style: TextStyle(fontSize: 16.sp)),
                      const Icon(
                        Icons.location_on,
                        color: Colors.red, // Replace with your 'danger' color
                      ),
                      Container(
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Colors
                                  .grey), // Replace with your 'secondary' color
                        ),
                        child: Center(
                          child: Text('Station $index'),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Visibility(
                  visible: !_isCollapsed,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(90.w, 4.h, 2.w, 2.h),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 8.0, 0),
                            child: Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(255, 127, 146, 228),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: Colors
                                    .grey), // Replace with your 'secondary' color
                          ),
                          child: Center(child: Text('Station $index')),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
