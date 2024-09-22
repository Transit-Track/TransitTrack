import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transittrack/features/authentication/presentation/pages/change_password_page.dart';
import 'package:transittrack/features/profile/presentation/pages/update_profile_page.dart';

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
        appBar: const CustomAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar and Edit Profile
              GestureDetector(
                onTap: () {
                  (context).read<AuthenticationBloc>().add(LogoutEvent());
                  (context).goNamed(AppPath.login);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 30,
                        color: secondary,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: secondary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/images/avatar_place_holder.jpg'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Navigate to Edit Profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfilePage()),
                  );
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Notifications toggle
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: Switch(
                  activeColor: primary,
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
                  (context).goNamed(AppPath.changePassword);
                },
              ),
              const Divider(),

              // Payment History
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Payment History'),
                onTap: () {
                  (context).goNamed(AppPath.paymentHistory);

                },
              ),
              const Divider(),

              // Send Feedback
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Send Feedback'),
                onTap: () {
                  // Navigate to send feedback page
                  (context).goNamed(AppPath.sendFeedback);
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
