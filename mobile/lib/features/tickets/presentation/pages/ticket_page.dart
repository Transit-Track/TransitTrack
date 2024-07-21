import 'package:flutter/material.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widget/custom_appbar_widget.dart';
import 'package:transittrack/core/widget/custom_navbar_widget.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Center(
          child: Text('ticket Page'),
        ),
        bottomNavigationBar: CustomNavbarWidget(),
      ),
    );;
  }
}