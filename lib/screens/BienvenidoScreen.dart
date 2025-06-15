import 'package:flutter/material.dart';

class BienvenidoScreen extends StatelessWidget {
  const BienvenidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido'),
            // TODO: Add navigation to LoginScreen or RegistroScreen
          ],
        ),
      ),
    );
  }
} 