import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';

class CustomDialogBoxWidget extends StatelessWidget {
  final String text;
  const CustomDialogBoxWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(32.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(danger),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: white),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(success),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
