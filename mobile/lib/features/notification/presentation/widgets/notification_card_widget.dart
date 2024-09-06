import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';

class NotificationCardWidget extends StatelessWidget {
  final BusEntity bus;
  const NotificationCardWidget({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From ${bus.start} To ${bus.destination}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Bus Number: ${bus.number}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/time.png',
                    width: 25.w,
                    height: 25.h,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${bus.arrivalTime} min',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Approaching to: ${bus.stationName}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
