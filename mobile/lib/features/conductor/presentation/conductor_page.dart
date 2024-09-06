import 'package:flutter/material.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';

class ConductorPage extends StatefulWidget {
  const ConductorPage({super.key});

  @override
  State<ConductorPage> createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(),
      body: Center(
        child: Text('Conductor Page'),
      ),
    );
  }
}
