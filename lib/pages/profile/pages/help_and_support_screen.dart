import 'package:budgetingapp/pages/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_data_provider.dart';
import 'help_detail_page.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Heading
                const Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBBDEFB),
                  ),
                ),
                const SizedBox(height: 30),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    hintText: "Search For help...",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Common Help Topics',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),

                _buildHelpTopic(context, 'How to create a budget'),
                _buildHelpTopic(context, 'Tracking expenses'),
                _buildHelpTopic(context, 'Managing categories'),
                _buildHelpTopic(context, 'Setting up notifications'),
                const Spacer(),

                // Contact Support Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showContactSupportBottomSheet(context);
                    },
                    label: const Text('Contact Support',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(360, 55),
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

  Widget _buildHelpTopic(BuildContext context, String topic) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        topic,
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
      onTap: () {
        MainContent.pushNewScreen(context, HelpDetailPage(topic: topic));
      },
    );
  }

  void _showContactSupportBottomSheet(BuildContext context) {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1976D2),
                Color(0xFFF1F8E9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Contact Support',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Choose your preferred method to contact our support team:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),

                // Email Support Button
                ElevatedButton.icon(
                  onPressed: () {
                    userDataProvider.emailSupport();
                  },
                  icon: const Icon(Icons.email, color: Colors.white),
                  label: const Text(
                    'Email Support',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 55),
                  ),
                ),
                const SizedBox(height: 12),

                // Call Support Button
                ElevatedButton.icon(
                  onPressed: () {
                    userDataProvider.callSupport();
                  },
                  icon: const Icon(Icons.phone, color: Colors.white),
                  label: const Text(
                    'Call Support',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 55),
                  ),
                ),
                const SizedBox(height: 12),

                // SMS Support Button
                ElevatedButton.icon(
                  onPressed: () {
                    userDataProvider.smsSupport();
                  },
                  icon: const Icon(Icons.sms, color: Colors.white),
                  label: const Text(
                    'SMS Support',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size(360, 55),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
