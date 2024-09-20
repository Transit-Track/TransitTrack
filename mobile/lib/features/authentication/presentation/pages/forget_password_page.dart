import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()=> {
        (context).goNamed(AppPath.login)
      },
      backgroundColor:Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),),
      child: const Icon(Icons.arrow_back)
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
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
                    height: screenHeight*0.3,
                  ),
                  SizedBox(
                    height: screenHeight*0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Forget Password',
                          style: TextStyle(fontSize: 32),
                        ),
                        const Text(
                          "Enter your phone number",
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
                            text: 'Next',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                              (context).pushNamed(AppPath.otpVerification);
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
