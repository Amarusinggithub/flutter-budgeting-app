import 'package:budgetingapp/pages/transaction/transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../budget/budget_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainContent();
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();

  static void pushNewScreen(BuildContext context, Widget screen,
      {bool isNavBarItem = false, int? tabIndex}) {
    if (isNavBarItem && tabIndex != null) {
      final mainScreenState =
          context.findAncestorStateOfType<_MainContentState>();
      if (mainScreenState != null) {
        mainScreenState._controller.jumpToTab(tabIndex);
      } else {
        if (kDebugMode) {
          print('MainScreenState not found in the widget tree');
        }
      }
    } else {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: screen,
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }
}

class _MainContentState extends State<MainContent> {
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
        icon: const Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.creditcard_fill),
        title: ("Transactions"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.blueAccent.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
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
