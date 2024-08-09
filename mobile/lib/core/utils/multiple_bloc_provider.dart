import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transittrack/core/injections/injection.dart' as di;

class MultipleBlocProvider extends StatelessWidget {
  final Widget child;
  const MultipleBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(create: (context) => di.sl<AuthenticationBloc>(),)
    ], child: child);
  }
}