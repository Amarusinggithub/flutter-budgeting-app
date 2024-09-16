import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_data_provider.dart';
import '../../services/auth_service.dart';
import '../onboarding/get_started_screen.dart';
import 'main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthService, UserDataProvider>(
      builder: (context, authService, userDataProvider, child) {
        if (!userDataProvider.isInitialized) {
          if (kDebugMode) {
            print("UserDataProvider not initialized");
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (authService.auth.currentUser != null &&
            userDataProvider.didUserFinishOnboarding) {
          if (kDebugMode) {
            print("Auth and onboarding complete");
          }
          return const MainScreen();
        } else {
          if (kDebugMode) {
            print("Auth or onboarding not complete");
          }
          return const GetStartedScreen();
        }
      },
    );
  }
}
