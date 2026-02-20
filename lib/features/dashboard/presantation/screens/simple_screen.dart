import 'package:flutter/material.dart';

class SimpleScreen extends StatelessWidget {
  final String title;

  const SimpleScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
