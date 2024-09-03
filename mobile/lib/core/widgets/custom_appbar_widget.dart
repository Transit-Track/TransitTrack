import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';

class CustomAppBarWidget extends StatelessWidget  implements PreferredSizeWidget{
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child:  Column(
          children: [
            SizedBox(
          height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
               Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/images/logo.png', width: 80.w, height: 80.h,),
                   Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: Text("Transit Track", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp, color: secondary),),
                  ),
                ],
                           ),
            Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          icon: const Icon(Icons.notifications_none_outlined),
                          onPressed: () {
                            (context).push(AppPath.notification);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                      child: IconButton(
                          icon: const Icon(Icons.person_outline_outlined),
                          onPressed: () {
                            (context).goNamed(AppPath.profile);
                          }),
                    ),
                  ],
                ),
          ],
        ),),
            SizedBox(
              height:1.h,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: secondary, thickness: 0.5,),
              ),),
          ],
        
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
