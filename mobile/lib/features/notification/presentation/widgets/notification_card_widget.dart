import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';

class NotificationCardWidget extends StatelessWidget {
  final BusEntity bus;
  const NotificationCardWidget({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(45),
        ),
        color: white,
      ),
      child: Column(
        children: [
          Text(
            'From ${bus.start} to ${bus.destination}',
            style: TextStyle(fontSize: 14.sp),
          ),
          Row(
            children: [
              Container(
                color: primary,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text('Bus Number: ${bus.number}'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Image.asset('assets/images/time.png'), Text(bus.arrivalTime)],
                ),
              ),

            ],
          ),
          Text('Approaching to: ${bus.stationName}')
        ],
      ),
    );
  }
}
