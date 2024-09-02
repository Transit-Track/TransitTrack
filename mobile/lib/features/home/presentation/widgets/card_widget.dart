import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';

class CardWidget extends StatelessWidget {
  final BusEntity bus;

  const CardWidget({
    super.key,
    required this.bus
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
        padding: EdgeInsets.fromLTRB(5.0.w, 10.0.h, 5.0.w, 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
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
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${bus.start} to ${bus.destination}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bus.number,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: const Color.fromARGB(255, 54, 54, 54).withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bus.distance} meters',
                      style: const TextStyle(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: ${bus.routes.length}ETB',
                      style: const TextStyle(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "See Route",
                            style: TextStyle(color: primary),
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
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
