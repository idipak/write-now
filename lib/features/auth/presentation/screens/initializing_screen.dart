import 'package:flutter/material.dart';

class InitializingScreen extends StatelessWidget {
  static const route = '/initializing-screen';
  const InitializingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
