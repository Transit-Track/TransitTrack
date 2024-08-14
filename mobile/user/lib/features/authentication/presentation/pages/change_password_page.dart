import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassswordController = TextEditingController();
  final TextEditingController _confirmNewPassswordController =
      TextEditingController();
  bool _isObsecurednew = false;
  bool _isObsecuredConfirm = false;

  @override
  void dispose() {
    super.dispose();
    _newPassswordController.dispose();
    _confirmNewPassswordController.dispose();
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your new Password';
    }

    if (value != _newPassswordController.text) {
      return 'Passwrod mismatch';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is ChangePasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } 
      },
      child: Scaffold(
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
                            controller: _newPassswordController,
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
                            controller: _confirmNewPassswordController,
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
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state is ChangePasswordLoadingState) {
                                return CircularProgressIndicator();
                              }

                              return ButtonWidget(
                                  context: context,
                                  text: 'Send',
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      (context).goNamed(AppPath.login);
                                    }

                                    //Bloc
                                    context.read<AuthenticationBloc>().add(
                                          ChangePasswordEvent(
                                              confirmPassword:
                                                  _confirmNewPassswordController
                                                      .text,
                                              newPassword:
                                                  _newPassswordController.text),
                                        );
                                  });
                            },
                          ),
                        ]),
                  )))),
    );
  }
}
