import 'package:flutter/material.dart';

class HelpDetailPage extends StatelessWidget {
  final String topic;

  const HelpDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            children: [
              // Custom header without AppBar
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getMainTitle(topic),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getSubTitle(topic),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Content inside a raised card for better contrast
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getTopicContent(topic),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMainTitle(String topic) {
    switch (topic) {
      case 'How to create a budget':
        return 'Creating a Budget';
      case 'Tracking expenses':
        return 'Tracking Your Expenses';
      case 'Managing categories':
        return 'Managing Spending Categories';
      case 'Setting up notifications':
        return 'Setting Up Notifications';
      default:
        return 'Help & Support';
    }
  }

  String _getSubTitle(String topic) {
    switch (topic) {
      case 'How to create a budget':
        return 'Organize your finances with a simple budget.';
      case 'Tracking expenses':
        return 'Monitor your spending efficiently.';
      case 'Managing categories':
        return 'Control how much you spend in different categories.';
      case 'Setting up notifications':
        return 'Never miss an important financial update.';
      default:
        return 'Helpful information about financial management.';
    }
  }

  Widget _getTopicContent(String topic) {
    switch (topic) {
      case 'How to create a budget':
        return _buildBudgetingContent();
      case 'Tracking expenses':
        return _buildExpenseTrackingContent();
      case 'Managing categories':
        return _buildManagingCategoriesContent();
      case 'Setting up notifications':
        return _buildNotificationsContent();
      default:
        return const Text(
          "Content not available for this topic.",
          style: TextStyle(fontSize: 16, color: Colors.red),
        );
    }
  }

  Widget _buildBudgetingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepText("1. List your income sources.", FontWeight.bold, 20),
        _buildStepText("2. Track your regular and irregular expenses.",
            FontWeight.w600, 18),
        _buildStepText(
            "3. Set spending limits for each category.", FontWeight.w600, 18),
        _buildStepText("4. Adjust your budget as necessary to save money.",
            FontWeight.w600, 18),
        _buildStepText("5. Monitor your budget regularly to stay on track.",
            FontWeight.w600, 18),
        const SizedBox(height: 20),
        const Text(
          "Tip: Use apps or budgeting tools to automate the process and make tracking easier.",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseTrackingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepText(
            "1. Record all your daily transactions.", FontWeight.bold, 20),
        _buildStepText(
            "2. Organize your spending by categories.", FontWeight.w600, 18),
        _buildStepText(
            "3. Review your spending patterns regularly.", FontWeight.w600, 18),
        _buildStepText("4. Compare your actual spending with your budget.",
            FontWeight.w600, 18),
        _buildStepText("5. Use apps or tools to automate expense tracking.",
            FontWeight.w600, 18),
        const SizedBox(height: 20),
        const Text(
          "Tip: Keeping receipts and reviewing them weekly helps keep expenses under control.",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildManagingCategoriesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepText(
            "1. Divide spending into categories like 'Food', 'Bills', etc.",
            FontWeight.bold,
            20),
        _buildStepText("2. Set limits for each category.", FontWeight.w600, 18),
        _buildStepText(
            "3. Adjust category limits as needed.", FontWeight.w600, 18),
        _buildStepText("4. Regularly review each category's spending.",
            FontWeight.w600, 18),
        _buildStepText(
            "5. Reallocate unused funds when necessary.", FontWeight.w600, 18),
        const SizedBox(height: 20),
        const Text(
          "Tip: Be flexible! Adjust categories as your spending habits change.",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepText("1. Open the app settings.", FontWeight.bold, 20),
        _buildStepText(
            "2. Enable notifications for budget limits.", FontWeight.w600, 18),
        _buildStepText("3. Customize notifications for specific categories.",
            FontWeight.w600, 18),
        _buildStepText(
            "4. Set reminders for bill payments.", FontWeight.w600, 18),
        _buildStepText(
            "5. Regularly check your notifications.", FontWeight.w600, 18),
        const SizedBox(height: 20),
        const Text(
          "Tip: Set reminders before due dates to avoid late fees.",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Step text helper
  Widget _buildStepText(String text, FontWeight fontWeight, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.6,
          fontWeight: fontWeight,
          color: Colors.black87,
        ),
      ),
    );
  }
}
