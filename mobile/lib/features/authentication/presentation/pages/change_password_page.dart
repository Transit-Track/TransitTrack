import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool _isObsecuredOld = true;
  bool _isObsecuredNew = true;
  bool _isObsecuredConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your new password';
    }

    if (value != _newPasswordController.text) {
      return 'Password mismatch';
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
        floatingActionButton: FloatingActionButton(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              0.5),
          backgroundColor: Colors.white,
          onPressed: () => (context).goNamed(AppPath.profile),
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0.w, 150.0.h, 30.w, 0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Old Password Field
                      InputFieldWidget(
                        hintText: 'Enter Old Password',
                        controller: _oldPasswordController,
                        context: context,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecuredOld = !_isObsecuredOld;
                            });
                          },
                          icon: !_isObsecuredOld
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        validation: passWordValidation,
                        keyboardType: TextInputType.visiblePassword,
                        obsecured: _isObsecuredOld,
                      ),
                      const SizedBox(height: 10),

                      // New Password Field
                      InputFieldWidget(
                        hintText: 'Enter New Password',
                        controller: _newPasswordController,
                        context: context,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecuredNew = !_isObsecuredNew;
                            });
                          },
                          icon: !_isObsecuredNew
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        validation: passWordValidation,
                        keyboardType: TextInputType.visiblePassword,
                        obsecured: _isObsecuredNew,
                      ),
                      const SizedBox(height: 10),

                      // Confirm New Password Field
                      InputFieldWidget(
                        hintText: 'Re-enter Password',
                        controller: _confirmNewPasswordController,
                        context: context,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecuredConfirm = !_isObsecuredConfirm;
                            });
                          },
                          icon: !_isObsecuredConfirm
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        validation: confirmPasswordValidation,
                        keyboardType: TextInputType.visiblePassword,
                        obsecured: _isObsecuredConfirm,
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is ChangePasswordLoadingState) {
                            return const CircularProgressIndicator();
                          }

                          return ButtonWidget(
                            context: context,
                            text: 'Send',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                context.goNamed(AppPath.login);
                              }

                              // Bloc: Trigger the ChangePasswordEvent
                              context.read<AuthenticationBloc>().add(
                                    ChangePasswordEvent(
                                      oldPassword: _oldPasswordController.text,
                                      confirmPassword:
                                          _confirmNewPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
