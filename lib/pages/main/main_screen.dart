import 'package:budgetingapp/pages/onboarding/get_started_screen.dart';
import 'package:budgetingapp/pages/transaction/transaction_screen.dart';
import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../services/auth_service.dart';
import '../budget/budget_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

  static void pushNewScreen(BuildContext context, Widget screen,
      {bool isNavBarItem = false, int? tabIndex}) {
    if (isNavBarItem && tabIndex != null) {
      (context as Element).visitAncestorElements((element) {
        if (element.widget is MainScreen) {
          (element as StatefulElement).state.setState(() {
            (element.state as _MainScreenState)._controller.jumpToTab(tabIndex);
          });
          return false;
        }
        return true;
      });
    } else {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: screen,
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }

  static void popUntilFirstScreenOnSelectedTabScreen(BuildContext context) {
    PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
      context,
      routeName: AppRoutes.home,
    );
  }

  static dynamic popUntil(BuildContext context) {
    return Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.home));
  }
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    // Check if the user is logged in and has finished onboarding
    if (authService.auth.currentUser != null &&
        userDataProvider.didUserFinishOnboarding) {
      // If the user is logged in and has finished onboarding, show the PersistentTabView
      return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        backgroundColor: const Color(0xFFF1F8E9),
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 700),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: 75,
        navBarStyle: NavBarStyle.style1,
      );
    } else {
      // If the user hasn't logged in or hasn't finished onboarding, show the GetStartedScreen
      return const GetStartedScreen();
    }
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const TransactionScreen(),
      const BudgetScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: MainScreen.popUntil(context),
        icon: const Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        onPressed: MainScreen.popUntil(context),
        icon: const Icon(CupertinoIcons.creditcard_fill),
        title: ("Transactions"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        onPressed: MainScreen.popUntil(context),
        icon: const Icon(CupertinoIcons.money_dollar_circle_fill),
        title: ("Budget"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        title: ("Profile"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
    ];
  }
}
