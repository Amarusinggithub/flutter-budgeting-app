import 'package:flutter/material.dart';

class NotificationAndThemesContainer extends StatelessWidget {
  const NotificationAndThemesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications_none_rounded),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Notifications"),
                    ],
                  ),
                  Text("On")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_paint_outlined),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Theme"),
                    ],
                  ),
                  Text("Ligth Mode")
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.language_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Language"),
                        ],
                      ),
                    ],
                  ),
                  Text("English")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
