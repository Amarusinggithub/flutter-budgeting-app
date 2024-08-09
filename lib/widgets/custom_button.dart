import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      style: ButtonStyle(
          elevation: WidgetStateProperty.all(4),
          alignment: Alignment.center,
          backgroundColor: WidgetStateProperty.all(Colors.black),
          padding: WidgetStateProperty.all(const EdgeInsetsDirectional.all(0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: const Color(0xFF660FFF),
          width: 300,
          height: 60,
          constraints: const BoxConstraints(
            maxWidth: 300,
            minHeight: 60,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
