import 'package:flutter/material.dart';

class HelpDetailPage extends StatelessWidget {
  final String topic;

  const HelpDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Detailed information about $topic.',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
