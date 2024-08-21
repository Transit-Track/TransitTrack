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
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
        pages[newIndex]();
        setState(() {});
      },
      items: const [
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: primary),
            icon: Icon(
              Icons.home_outlined,
              color: black,
            ),
            label: 'Home',
            tooltip: 'Home',
            backgroundColor: white),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.route, color: primary),
          icon: Icon(
            Icons.route,
            color: black,
          ),
          label: 'My Route',
          tooltip: 'My Route',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.airplane_ticket, color: primary),
          icon: Icon(
            Icons.airplane_ticket_outlined,
            color: black,
          ),
          label: 'Ticket',
          tooltip: 'Ticket',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person, color: primary),
          icon: Icon(
            Icons.person_outline,
            color: black,
          ),
          label: 'Profile',
          tooltip: 'Profile',
        ),
      ],
      selectedItemColor: primary, // Color of the label when item is selected
    );
  }
}
