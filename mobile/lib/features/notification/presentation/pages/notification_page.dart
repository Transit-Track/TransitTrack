import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/features/driver/domain/entity/driver_entity.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/entities/route_entity.dart';
import 'package:transittrack/features/home/domain/entities/station_entity.dart';
import 'package:transittrack/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:transittrack/features/tickets/presentation/pages/QR_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<BusEntity> notifications = [
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "1",
      id: "",
      type: "anbessa",
      number: "17",
      price: 10,
      route: RouteEntity(
        distance: 10.3,
        id: '1',
        stations: [
          StationEntity(
              stationId: '1',
              name: 'Shiro Meda',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '2',
              name: '4 Kilo',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '3',
              name: 'Piassa',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '4',
              name: 'Stadium',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '5',
              name: 'Meskel Square',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '6',
              name: 'Mexico',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
        ],
      )),
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "2",
      id: "",
      type: "anbessa",
      number: "83",
      price: 15,
      route: RouteEntity(
        distance: 10.3,
        id: '1',
        stations: [
          StationEntity(
              stationId: '1',
              name: 'Shiro Meda',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '2',
              name: '4 Kilo',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '3',
              name: 'Piassa',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '4',
              name: 'Stadium',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '5',
              name: 'Meskel Square',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
          StationEntity(
              stationId: '6',
              name: 'Mexico',
              geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
        ],
      )),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
        backgroundColor: Colors.white,
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Row(
                children: [
                  const Icon(Icons.notifications, color: Colors.black),
                  SizedBox(width: 16.w),
                  Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: notifications.isNotEmpty
                  ? ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QRCodePage(),
                            ),
                          );
                        },
                          child: NotificationCardWidget(bus: notifications[index]));
                      },
                    )
                  : Center(
                      child: Text(
                        'No notifications available',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
