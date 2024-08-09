import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';

class LogoutContainer extends StatelessWidget {
  const LogoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          authService.logout();
        },
        child: Container(
          child: const Row(
            children: [
              Icon(Icons.logout),
              SizedBox(
                width: 8,
              ),
              Text("Logout"),
            ],
          ),
        ),
      ),
    );
  }
}
