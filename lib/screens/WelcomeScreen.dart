import 'package:flutter/material.dart';
import '../auth/LoginScreen.dart';
import '../auth/RegistroScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegistroScreen(),
                        ),
                      );
                    },
                    child: const Text('Registro'),
                  ),
                ],
              ),
            ),
          ),
          const Text('Nombre: Wilmer Betancourt'),
          const SizedBox(height: 10),
          const Text('Github: gabr13l195'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
} 