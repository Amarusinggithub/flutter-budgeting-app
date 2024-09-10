import 'package:budgetingapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../provider/terms_and_condition_provider.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final termsProvider = Provider.of<TermsAndConditionsProvider>(context);

    return Scaffold(
      body: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Top image
              Center(
                child: Image.asset(
                  Assets.imagesTermsAndConditions,
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Terms & Conditions title
              const Center(
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // White text for better contrast
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description text
              const Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "The Customer agrees that Budgetize may use, process, and host customer confidential information/data such as bank details, contact information, and other credentials for processing transactions.\n\n"
                      "By using this app, you agree to our Terms & Conditions and Privacy Policy. You also agree that Budgetize may charge the necessary fees from your wallet or account for processing your financial transactions.",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Checkbox for agreeing to Terms & Conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blueAccent,
                    shape: CircleBorder(),
                    value: termsProvider.agreeTerms,
                    onChanged: (value) {
                      termsProvider.toggleAgreeTerms(value!);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to the Terms and Conditions",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              // Checkbox for agreeing to the Privacy Policy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blueAccent,
                    shape: CircleBorder(),
                    value: termsProvider.agreePrivacy,
                    onChanged: (value) {
                      termsProvider.toggleAgreePrivacy(value!);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to the Privacy Policy",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              // Select All GestureDetector
              GestureDetector(
                onTap: () {
                  // Toggle both checkboxes
                  termsProvider.selectAll(!termsProvider.areBothAgreed);
                },
                child: const Text(
                  "Select all",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Decline and Accept Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Decline Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.red.shade400,
                      fixedSize: const Size(140, 55),
                    ),
                    child: const Text(
                      "Decline",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Accept Button
                  ElevatedButton(
                    onPressed: termsProvider.areBothAgreed
                        ? () {
                            Navigator.pushNamed(
                                context, AppRoutes.whyChooseAppPage);
                          }
                        : null, // Disable if not both agreed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: termsProvider.areBothAgreed
                          ? Colors.blueAccent
                          : Colors.grey,
                      fixedSize: const Size(140, 55),
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
