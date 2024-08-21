import 'package:flutter/material.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';

class MyRoute extends StatefulWidget {
  const MyRoute({super.key});

  @override
  State<MyRoute> createState() => _MyRouteState();
}

class _MyRouteState extends State<MyRoute> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Center(
          child: Text('Favorite Page'),
        ),
        bottomNavigationBar: CustomNavbarWidget(),
      ),
    );
    ;
  }
}
