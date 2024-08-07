import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transittrack/core/routes/router_config.dart';
import 'package:transittrack/core/utils/multiple_bloc_provider.dart';
import './env/env.dart';
import 'package:transittrack/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;

  runApp(MultipleBlocProvider(
    child: MyApp(
      onboarding: onboarding,
      googleApiKey: Env.googleApiKey,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final String googleApiKey;
  const MyApp({
    super.key,
    this.onboarding = false,
    required this.googleApiKey

  });

  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(
      context,
      designSize: Size(375, 812), // Set the design size according to your design
      minTextAdapt: true,
      splitScreenMode: true,
    );
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Laila',
      ),
      routerConfig: AppRouter.router,
    );
  }
}
