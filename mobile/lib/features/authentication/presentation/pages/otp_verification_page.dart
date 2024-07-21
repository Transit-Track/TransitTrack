import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widget/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 90, 15, 0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/otp.png',
                    width: 430,
                    height: 272,
                  ),
                  Container(
                    height: 210,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'OTP Verification code',
                          style: TextStyle(fontSize: 32),
                        ),
                        const Text(
                          "Enter email or phone number",
                          style:
                              TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3.0, 25, 2, 25),
                          child: InputFieldWidget(
                            hintText: 'Phone Number',
                            controller: phoneNumberController,
                            context: context,
                            validation: phoneNumberValidation,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        ButtonWidget(
                            context: context,
                            text: 'Send',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                              (context).goNamed(AppPath.sendOtpVerification);
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
