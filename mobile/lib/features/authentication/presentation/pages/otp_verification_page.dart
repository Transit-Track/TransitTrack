import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => {(context).goNamed(AppPath.login)},
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 2)),
              child: const Icon(Icons.arrow_back)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(15.0, screenHeight * 0.1, 15, 0),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/otp.png',
                  width: 430,
                  height: screenHeight * 0.3,
                ),
                Container(
                  height: screenHeight * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'OTP Verification code',
                        style: TextStyle(fontSize: 32),
                      ),
                      const Text(
                        "Enter the verification code sent",
                        style:
                            TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
                      ),
                      OtpTextField(
                          numberOfFields: 6,
                          borderColor: primary,
                          showFieldAsBox: true,
                          fieldHeight: 50,
                          fieldWidth: 50,
                          onSubmit: (code) {
                          }),
                      ButtonWidget(
                          context: context,
                          text: 'Next',
                          onClick: () {
                            (context).pushNamed(AppPath.changePassword);
                          }),
                      Container(
                          child: Column(
                        children: [resend(), Text('Resend')],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget resend() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.refresh,
          color: white,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: primary),
    );
  }
}
