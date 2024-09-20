import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';
import 'package:transittrack/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:transittrack/features/tickets/presentation/pages/QR_page.dart';

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
