import 'package:budgetingapp/pages/profile/components/account_info_container.dart';
import 'package:budgetingapp/pages/profile/components/help_andsupport.dart';
import 'package:budgetingapp/pages/profile/components/logoutcontainer.dart';
import 'package:budgetingapp/pages/profile/components/notification_and_themes_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 60),
            color: Colors.green,
            height: 320,
            width: double.infinity,
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 80,
                ),
                Text("UserName"),
                Text("Email")
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 15, horizontal: 15),
              child: Column(
                children: [
                  AccountInfoContainer(),
                  SizedBox(
                    height: 15,
                  ),
                  NotificationAndThemesContainer(),
                  SizedBox(
                    height: 15,
                  ),
                  HelpAndsupport(),
                  SizedBox(
                    height: 27,
                  ),
                  LogoutContainer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
