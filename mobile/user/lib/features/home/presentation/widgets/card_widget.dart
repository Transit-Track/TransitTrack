import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';

class CardWidget extends StatelessWidget {
  final String stationName;
  final String distance;
  final String arrivalTime;
  final String numberOfStops;
  final String busNumber;
  final String busType;

  const CardWidget({
    super.key,
    required this.stationName,
    required this.distance,
    required this.arrivalTime,
    required this.numberOfStops,
    required this.busNumber,
    required this.busType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    'assets/images/anbessa.png',
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Anbessa Bus',
                style: TextStyle(fontSize: 10.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
            width: 30.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 2.w),
                  Text(
                    stationName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                    width: 35.w,
                  ),
                  Row(
                    children: [
                      Text(
                        busNumber,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                        width: 10.w,
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Color.fromARGB(255, 54, 54, 54).withOpacity(0.5),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    distance + ' meters',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 1.h,
                    width: 45.w,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    numberOfStops + ' stops',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 1.h,
                    width: 50.w,
                  ),
                  Row(
                    children: [
                      Text(
                        "See Route",
                        style: TextStyle(color: primary),
                      ),
                      SizedBox(
                        height: 1.h,
                        width: 10.w,
                      ),
                      Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                            size: 30.sp,
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
