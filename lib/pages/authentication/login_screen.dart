import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../generated/assets.dart';
import '../../provider/user_data_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1976D2),
                  Color(0xFFF1F8E9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                Assets.imagesWalletMobileApp,
                fit: BoxFit.contain,
                height: 220,
                width: 220,
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Login",
                  style: TextStyle(
                    color: Color(0xFFBBDEFB),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setEmail(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setPassword(value);
                  },
                  obscureText: !userDataProvider.isPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        userDataProvider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        userDataProvider.togglePasswordVisibility();
                      },
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (userDataProvider.validateFieldsForSignIn()) {
                      userDataProvider.login();
                      userDataProvider.toggleToTrueDidUserFinishOnboarding();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "All fields are required, and passwords must match!"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 55),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.getStartedPage);
                  },
                  child: const Text(
                    "Not yet Registered? Sign Up Now",
                    style: TextStyle(
                      color: Color(0xFF6D77FB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
