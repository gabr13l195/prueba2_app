import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/WelcomeScreen.dart';

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://qnjtzkxlfluarnhkarwi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuanR6a3hsZmx1YXJuaGthcndpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5NDAzNTIsImV4cCI6MjA2NTUxNjM1Mn0.YJMyuJtApJUnrziYrxqnK5q3_LJrWTLr1csRGu3h298',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
