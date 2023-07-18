import 'package:flutter/material.dart';

class ChekAuthStatusScreen extends StatelessWidget {
  const ChekAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}