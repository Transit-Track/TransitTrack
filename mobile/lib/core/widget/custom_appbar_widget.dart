import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            Container(
          height: 60,
        child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                      icon: Icon(Icons.notifications_none_outlined),
                      onPressed: () {
                        (context).goNamed(AppPath.notification);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: IconButton(
                      icon: Icon(Icons.person_outline_outlined),
                      onPressed: () {
                        (context).goNamed(AppPath.profile);
                      }),
                ),
              ],
            ),),
            Container(
              height:2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: secondary, thickness: 0.5,),
              ),),
          ],
        
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}
