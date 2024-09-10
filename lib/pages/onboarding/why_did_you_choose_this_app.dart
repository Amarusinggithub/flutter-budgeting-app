import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../generated/assets.dart';
import '../../provider/user_selection_provider.dart';

class WhyDidYouChooseThisApp extends StatelessWidget {
  const WhyDidYouChooseThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> options = [
      {
        'image': Assets.imagesClipManSavingBitcoinInPiggyBank,
        'text': 'Easy to Use',
      },
      {
        'image': Assets.imagesClipManSavingBitcoinInPiggyBank,
        'text': 'Effective Budgeting',
      },
      {
        'image': Assets.imagesClipManSavingBitcoinInPiggyBank,
        'text': 'Secure Transactions',
      },
      {
        'image': Assets.imagesClipManSavingBitcoinInPiggyBank,
        'text': 'Real-time Tracking',
      },
    ];

    final userSelectionProvider = Provider.of<UserSelectionProvider>(context);

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  GestureDetector(
                      onTap: () {},
                      child: const Text("Skip",
                          style: TextStyle(color: Colors.white))),
                ],
              ),
              const SizedBox(height: 20),

              // Title Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Why did you choose Budgetize?",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Tell us by choosing from the options:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Options List
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Toggling the option selection
                        userSelectionProvider.toggleOption(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: userSelectionProvider.isSelected(index),
                              onChanged: (bool? newValue) {
                                userSelectionProvider.toggleOption(index);
                              },
                              splashRadius: 30,
                              checkColor: Colors.white,
                              activeColor: Colors.blueAccent,
                              shape: const CircleBorder(),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              options[index]['image'],
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                options[index]['text'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                                overflow: TextOverflow.visible,
                                softWrap: false, // Disable wrapping
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: userSelectionProvider.selectedOptions.isNotEmpty
                      ? () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor:
                        userSelectionProvider.selectedOptions.isNotEmpty
                            ? Colors.blueAccent
                            : Colors.grey[400],
                    fixedSize: const Size(360, 55),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
