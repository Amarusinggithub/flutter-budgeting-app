import 'package:flutter/cupertino.dart';

import '../../pages/authentication/login_screen.dart';
import '../../pages/authentication/register_screen.dart';
import '../../pages/main/main_screen.dart';
import '../../pages/notification/notification_screen.dart';
import '../../pages/profile/profile_screen.dart';

class AppRoutes {
  static const String home = '/';

  static const String login = "/login";
  static const String register = "/register";
  static const String notification = "/notification";

  static const String account = "/account";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const MainScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      notification: (context) => const NotificationScreen(),
      account: (context) => const ProfileScreen(),
    };
  }
}
