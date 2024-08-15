import 'package:driver/core/routes/app_path.dart';
import 'package:driver/core/utils/validation.dart';
import 'package:driver/core/widgets/button_widget.dart';
import 'package:driver/features/authentication/presentation/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _driverNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObsecured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 100, 30, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Text(
                  "👋 Hi, Welcome Back",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
                  child: InputFieldWidget(
                    hintText: 'Driving licence number',
                    controller: _driverNumberController,
                    context: context,
                    validation: null,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
                  child: InputFieldWidget(
                    obsecured: _isObsecured,
                    hintText: 'Password',
                    controller: _passwordController,
                    context: context,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsecured = !_isObsecured;
                          });
                        },
                        icon: !_isObsecured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    validation: passWordValidation,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ButtonWidget(
                  context: context,
                  text: 'Log In',
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      (context).goNamed(AppPath.trackingPage);
                      // Bloc
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
