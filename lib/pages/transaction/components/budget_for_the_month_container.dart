import 'package:flutter/material.dart';

class BudgetForTheMonthContainer extends StatelessWidget {
  const BudgetForTheMonthContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 104,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF3B82F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Budget for this Month',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$2,478',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                width: 287,
                height: 6,
                decoration: ShapeDecoration(
                  color: const Color(0xFF93C5FD),
                  // Lighter blue for the progress bar background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 250, // Adjust the width for the filled portion
                  height: 6,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF60A5FA),
                    // Slightly darker blue for the filled portion
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
