import 'package:budgetingapp/pages/onboarding/finish_onboarding_process_screen.dart';
import 'package:budgetingapp/pages/onboarding/set_up_initial_budget_onboarding_screen.dart';
import 'package:budgetingapp/pages/onboarding/terms_and_conditions_screen.dart';
import 'package:budgetingapp/pages/onboarding/why_did_you_choose_this_app.dart';
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
  static const String whyChooseAppPage = "/why_choose_this_app";
  static const String account = "/account";
  static const String termsAndConditions = "/termsAndConditions";
  static const String setUpBudget = "/setUpBudget";
  static const String finishOnboarding = "/finishOnboarding";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const MainScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      notification: (context) => const NotificationScreen(),
      account: (context) => const ProfileScreen(),
      termsAndConditions: (context) => const TermsAndConditionsScreen(),
      whyChooseAppPage: (context) => const WhyDidYouChooseThisApp(),
      setUpBudget: (context) => const SetUpInitialBudgetOnboardingScreen(),
      finishOnboarding: (context) => const FinishOnboardingProcessScreen(),
    };
  }
}
