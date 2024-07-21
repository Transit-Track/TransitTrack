import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widget/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPassswordController = TextEditingController();
  final TextEditingController confirmNewPassswordController =
      TextEditingController();
  bool _isObsecurednew = false;
  bool _isObsecuredConfirm = false;

  @override
  void dispose() {
    super.dispose();
    newPassswordController.dispose();
    confirmNewPassswordController.dispose();
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your new Password';
    }

    if (value != newPassswordController.text) {
      return 'Passwrod mismatch';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 100, 30, 0),
            child: Container(
                height: 450,
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
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputFieldWidget(
                          hintText: 'Enter New Pasword',
                          controller: newPassswordController,
                          context: context,
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObsecurednew = !_isObsecurednew;
                                });
                              },
                              icon: !_isObsecurednew
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          validation: passWordValidation,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        InputFieldWidget(
                          obsecured: _isObsecuredConfirm,
                          hintText: 'Re-enter password',
                          controller: confirmNewPassswordController,
                          context: context,
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObsecuredConfirm = !_isObsecuredConfirm;
                                });
                              },
                              icon: !_isObsecuredConfirm
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          validation: confirmPasswordValidation,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonWidget(
                            context: context,
                            text: 'Send',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                (context).goNamed(AppPath.login);
                              }
                            }),
                      ]),
                ))));
  }
}
