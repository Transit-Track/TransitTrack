import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<SendFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            0.5),
        backgroundColor: Colors.white,
        onPressed: () => {
          (context).goNamed(AppPath.profile)
          },
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0.w, 130.h, 16.0.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '👋',
                  style: TextStyle(fontSize: 20.w),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Hi there, you can easily share your thoughts, ideas, and any issues you have encountered.',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Feedback",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600,),
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color.fromARGB(255, 108, 162, 255)),
              ),
              child: TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0.h),
                  border: InputBorder.none,
                  hintText: 'Write your feedback here...',
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  backgroundColor: primary,
                ),
                onPressed: () {
                  // Handle feedback submission
                  if (_feedbackController.text.isNotEmpty) {
                    // Example submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Thank you for your feedback!'),
                          backgroundColor: success,),
                    );
                    _feedbackController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter some feedback.')),
                    );
                  }
                },
                child: Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
