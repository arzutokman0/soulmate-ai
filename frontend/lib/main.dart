import 'package:flutter/material.dart';
import 'views/character_selection_view.dart';

void main() {
  runApp(const SoulMateKidsApp());
}

class SoulMateKidsApp extends StatelessWidget {
  const SoulMateKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoulMate Kids',
      theme: ThemeData(
        fontFamily: 'Comic Sans MS',
        useMaterial3: true,
      ),
      home: const CharacterSelectionScreen(),
    );
  }
}
