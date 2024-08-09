import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var _isObsecured;

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
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
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      InputFieldWidget(
                        hintText: 'Full Name',
                        controller: fullNameController,
                        context: context,
                        validation: null,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InputFieldWidget(
                        hintText: 'Email',
                        controller: emailController,
                        context: context,
                        validation: emailValidation,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InputFieldWidget(
                        hintText: 'Phone Number',
                        controller: phoneNumberController,
                        context: context,
                        validation: phoneNumberValidation,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InputFieldWidget(
                        obsecured: _isObsecured,
                        hintText: 'Password',
                        controller: passwordController,
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
                      SizedBox(
                        height: 25.h,
                      ),
                      ButtonWidget(
                          context: context,
                          text: 'Sign Up',
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              (context).goNamed(AppPath.login);
                            }
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          (context).goNamed(AppPath.login);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do you have an account? '),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    ]),
              ))),
    );
  }
}
