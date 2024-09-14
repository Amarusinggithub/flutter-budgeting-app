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
    final authService = Provider.of<AuthService>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    if (!userDataProvider.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (authService.auth.currentUser != null &&
        userDataProvider.didUserFinishOnboarding) {
      return const MainScreen();
    } else {
      return const GetStartedScreen();
    }
  }
}
