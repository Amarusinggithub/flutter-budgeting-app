import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectALimitContainer extends StatelessWidget {
  const SelectALimitContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
        final limits = notificationProvider.dailyLimits;
        final selectedLimit = notificationProvider.selectedLimitIndex;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enable Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Switch(
              value: notificationProvider.selectedLimitIndex > 0,
              onChanged: (value) {
                notificationProvider.updateSelectLimit(value ? 3 : 0);
              },
              activeColor: Colors.blueAccent.shade400,
            ),
            const Text(
              'Choose Notification Limit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(limits.length, (index) {
                final limit = limits[index];
                return ChoiceChip(
                  selectedColor: Colors.blueAccent,
                  label: Text("$limit"),
                  selected: index == selectedLimit,
                  onSelected: (selected) {
                    if (selected) {
                      notificationProvider.updateSelectLimit(index);
                    }
                  },
                  elevation: 4,
                  checkmarkColor: Colors.white,
                  side: const BorderSide(style: BorderStyle.none),
                  avatarBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  chipAnimationStyle: ChipAnimationStyle(
                      selectAnimation: AnimationStyle(
                          duration: const Duration(milliseconds: 1000))),
                  backgroundColor: Colors.white.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
