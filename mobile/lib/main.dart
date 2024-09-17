import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transittrack/core/keys/keys.dart';
import 'package:transittrack/core/routes/router_config.dart';
import 'package:transittrack/core/utils/multiple_bloc_provider.dart';
import 'package:transittrack/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:transittrack/firebase_options.dart';
import 'core/injections/injection.dart' as di;

Future main() async {
  MpesaFlutterPlugin.setConsumerKey(mConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final localDataSource = di.sl<AuthenticationLocalDataSource>();
  final user = await localDataSource.getUserCredentials();
  final String? role = user!.role;

  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  runApp(MultipleBlocProvider(
    child: MyApp(
      onboarding: onboarding,
      role: role,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final String? role;
  const MyApp({
    super.key,
    this.onboarding = false,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ScreenUtil.init(
          context,
          designSize:
              Size(375, 812), // Set the design size according to your design
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
          routerConfig: AppRouter.router(onboarding, role),
        );
      },
    );
  }
}
