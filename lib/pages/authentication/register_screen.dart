import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../generated/assets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
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
                Assets.imagesClipManSavingBitcoinInPiggyBank,
                fit: BoxFit.contain,
                height: 180,
                width: 180,
              ),
            ),
          ),
          Positioned(
            top: 230,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xFFBBDEFB),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),

                // Username Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setUsername(value);
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
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

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
                      Icons.email,
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
                const SizedBox(height: 16),

                // Confirm Password Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setConfirmPassword(value);
                  },
                  obscureText: !userDataProvider.isConfirmPasswordVisible,
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
                        userDataProvider.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        userDataProvider.toggleConfirmPasswordVisibility();
                      },
                    ),
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (userDataProvider.validateFields()) {
                      userDataProvider.register();
                      Navigator.pushNamed(context, AppRoutes.setUpBudget);
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
                    "Sign Up",
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
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    "Already have an account? Login Now",
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
