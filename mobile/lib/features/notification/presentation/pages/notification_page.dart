import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';
import 'package:transittrack/features/notification/presentation/widgets/notification_card_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              0.5),
          backgroundColor: Colors.white,
          onPressed: () => {(context).pop()},
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.notifications),
              SizedBox(
                width: 23.w,
              ),
              Text('Notifications'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCardWidget(bus: notifications[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
