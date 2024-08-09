import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool _isObsecured;

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
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
                        "👋 Hi, Welcome Back",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      InputFieldWidget(
                        hintText: 'Phone Number',
                        controller: phoneNumberController,
                        context: context,
                        validation: phoneNumberValidation,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 20.h,
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ButtonWidget(
                          context: context,
                          text: 'Log In',
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              (context).goNamed(AppPath.home);
                            }
                          }),
                      // GestureDetector(
                      //   onTap: () {
                      //     (context).pushNamed(AppPath.forgetPassword);
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       const Text('Forgot your password?'),
                      //       const SizedBox(
                      //         width: 4,
                      //       ),
                      //       ForwardWidget(
                      //           color: Theme.of(context).primaryColor),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          (context).goNamed(AppPath.signup);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't you have an account? "),
                            Text(
                              "Sign Up",
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

  @override
  void setHeight(size) => {};
}
