import 'package:flutter/material.dart';
import 'screens/character_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulMate Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E35B1)),
        useMaterial3: true,
      ),
      home: const CharacterSelectionScreen(), // Macera buradan başlıyor!
    );
  }
}
