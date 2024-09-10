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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xFF6D77FB),
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  Assets.imagesClipManSavingBitcoinInPiggyBank,
                  fit: BoxFit.contain,
                  height: 220,
                  width: 220,
                ),
                const SizedBox(height: 25),

                // Username Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setUsername(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 25),

                // Email Field
                TextField(
                  onChanged: (value) {
                    userDataProvider.setEmail(value);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
                      fillColor: Colors.white.withOpacity(0.4)),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 25),

                // Password Field
                TextField(
                  onChanged: (value) {
                    // Update password in the provider
                    userDataProvider.setPassword(value);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blueAccent,
                      ),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4)),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    userDataProvider.register();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 60),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Navigate to Login
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    "Already have an account? Login Now",
                    style: TextStyle(
                      color: Color(0xFF6D77FB),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
