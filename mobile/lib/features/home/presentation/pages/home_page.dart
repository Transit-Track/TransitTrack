import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widget/button_widget.dart';
import 'package:transittrack/core/widget/custom_appbar_widget.dart';
import 'package:transittrack/core/widget/custom_navbar_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const CustomAppBarWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _startController,
                          decoration: InputDecoration(
                              labelText: 'Start',
                              hintText: 'Enter your start location',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _destinationController,
                          decoration: InputDecoration(
                              labelText: 'Destination',
                              hintText: 'Enter your destination location',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ButtonWidget(
                          context: context,
                          text: 'Search',
                          onClick: () {
                            (context).goNamed(AppPath.test);
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Nearby Station Stops',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      // Wrap(children: ListView.builder(itemBuilder: itemBuilder),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomNavbarWidget(),
      ),
    );
  }
}
