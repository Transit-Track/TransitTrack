import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/widgets/button_widget.dart';

class PaymentMethodCardWidget extends StatelessWidget {
  final Color color;
  final String imagePath;
  final VoidCallback? onPressed;

  const PaymentMethodCardWidget(
      {super.key,
      this.color = Colors.white,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Container(
        width: 200,
        height: 40.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(209, 223, 243, 1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(imagePath, width: 180, height: 109),
              SizedBox(height: 10.h),
              ButtonWidget(context: context, text: 'Buy', onClick: onPressed!, height: 50.h, width: 100.w,)
            ],
          )),
    );
  }
}
