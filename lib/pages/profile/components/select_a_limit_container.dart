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
            Text(
              'Notification Limit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(limits.length, (index) {
                final limit = limits[index];
                return ChoiceChip(
                  label: Text("$limit"),
                  selected: index == selectedLimit,
                  onSelected: (selected) {
                    if (selected) {
                      notificationProvider.updateSelectLimit(index);
                    }
                  },
                  selectedColor: Colors.blueAccent,
                  labelStyle: TextStyle(
                    color: index == selectedLimit
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                  backgroundColor: Colors.grey[200],
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
