import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transittrack/features/authentication/presentation/widget/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _isObsecured;

  @override
  void initState() {
    super.initState();
    _isObsecured = true;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          // ScaffoldMessenger.of(context).showSnackBar(
            // SnackBar(
             //  content: Text(state.message),
              // backgroundColor: Colors.red,
            // ),
          // );
           (context).goNamed(AppPath.home);
        } else if (state is LoggedInState) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Succesfluy Loged in'),
          //     backgroundColor: Colors.green,
          //   ),
          // );
          (context).goNamed(AppPath.home);
        }
      },
      child: Scaffold(
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
                          controller: _phoneNumberController,
                          context: context,
                          // validation: null,
                          validation: phoneNumberValidation,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InputFieldWidget(
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
                          validation: null,
                          // validation: passWordValidation,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const CircularProgressIndicator();
                            }
                            return ButtonWidget(
                                context: context,
                                text: 'Log In',
                                onClick: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Bloc
                                    context.read<AuthenticationBloc>().add(
                                          LogInEvent(
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                  }
                                });
                          },
                        ),
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
      ),
    );
  }

  @override
  void setHeight(size) => {};
}
