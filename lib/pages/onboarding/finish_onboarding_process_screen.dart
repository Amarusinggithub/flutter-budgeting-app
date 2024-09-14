import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../provider/user_data_provider.dart';

class FinishOnboardingProcessScreen extends StatelessWidget {
  const FinishOnboardingProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success icon
            Image.asset(
              Assets.imagesTick,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),

            // Congratulations message
            const Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Subtitle
            const Text(
              "You've successfully signed up and created your first budget. Welcome to the start of your financial journey!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // "Done" button
            ElevatedButton(
              onPressed: () async {
                await userDataProvider.toggleToTrueDidUserFinishOnboarding();
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
                'Done',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
