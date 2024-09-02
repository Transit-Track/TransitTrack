import 'package:flutter/material.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar and Edit Profile
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Notifications toggle
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ),
              const Divider(),

              // Change Password
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  // Navigate to change password page
                },
              ),
              const Divider(),

              // Payment History
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Payment History'),
                onTap: () {
                  // Navigate to payment history page
                },
              ),
              const Divider(),

              // Send Feedback
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Send Feedback'),
                onTap: () {
                  // Navigate to send feedback page
                },
              ),
              const Divider(),

              // Logout
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Implement logout functionality
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavbarWidget(),
      ),
    );
  }
}
