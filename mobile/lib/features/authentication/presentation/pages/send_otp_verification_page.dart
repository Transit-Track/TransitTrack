import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/widget/button_widget.dart';

class SendOtpVerificationPage extends StatefulWidget {
  const SendOtpVerificationPage({super.key});

  @override
  State<SendOtpVerificationPage> createState() => _SendOtpVerificationPageState();
}

class _SendOtpVerificationPageState extends State<SendOtpVerificationPage> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
                      const Text('OTP Verification code', style: TextStyle(fontSize: 32),),
                      const Text("Enter email or phone number", style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(3.0,25,2,25),
                       
                      ),
                      ButtonWidget(
                          context: context,
                          text: 'Send',
                          onClick: () {
                            (context).goNamed(AppPath.forgetPassword);
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}