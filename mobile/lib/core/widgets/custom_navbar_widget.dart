import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';

class CustomNavbarWidget extends StatefulWidget {
  const CustomNavbarWidget({super.key});

  @override
  State<CustomNavbarWidget> createState() => _CustomNavbarWidgetState();
}

class _CustomNavbarWidgetState extends State<CustomNavbarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Function> pages = [
      () => (context).goNamed(AppPath.home),
      () => (context).goNamed(AppPath.my_route),
      () => (context).goNamed(AppPath.ticket),
      () => (context).goNamed(AppPath.profile),
    ];
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
        pages[newIndex]();
      },
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: white),
          icon: Icon(
            Icons.home_outlined,
            color: black,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.route, color: white),
          icon: Icon(
            Icons.route,
            color: black,
          ),
          label: 'My Route',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.airplane_ticket, color: white),
          icon: Icon(
            Icons.airplane_ticket_outlined,
            color: black,
          ),
          label: 'Ticket',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person, color: white),
          icon: Icon(
            Icons.person_outline,
            color: black,
          ),
          label: 'Profile',
        ),
      ],
      backgroundColor: white,
      indicatorColor: primary,
    );
  }
}