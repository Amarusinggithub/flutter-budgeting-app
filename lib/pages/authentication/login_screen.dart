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
                  "Login",
                  style: TextStyle(
                    color: Color(0xFF6D77FB),
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
                const SizedBox(height: 40),

                Image.asset(
                  Assets.imagesWalletMobileApp,
                  fit: BoxFit.contain,
                  height: 250,
                  width: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    // Update email in the provider
                    userDataProvider.setEmail(value);
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
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 25),
                // Adjusted spacing

                TextField(
                  onChanged: (value) {
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
                    fillColor: Colors.grey[200],
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    userDataProvider.login();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 60), // Standardized button size
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22, // Clean and bold font
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Adjusted space after the button

                // Sign Up Text
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: const Text(
                    "Not yet Registered? Sign Up Now",
                    style: TextStyle(
                      color: Color(0xFF6D77FB),
                      fontSize: 16, // Increased font size for readability
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
