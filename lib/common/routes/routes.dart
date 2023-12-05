import 'package:flutter/material.dart';
import 'package:todo/features/auth/screens/login_screen.dart';
import 'package:todo/features/auth/screens/otp_screen.dart';
import 'package:todo/features/onboarding/screens/onboarding.dart';
import 'package:todo/features/todo/screens/homepage.dart';

class Routes {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoarding(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => OtpScreen(
            phone: args['phone'] as String,
            smsCodeId: args['smsCodeId'] as String,
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
