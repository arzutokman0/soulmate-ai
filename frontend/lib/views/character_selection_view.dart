import 'package:flutter/material.dart';
import '../models/colors.dart';
import '../components/character_card.dart';
import 'emotion_selection_view.dart';

class CharacterSelectionScreen extends StatelessWidget {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [SoulMateColors.skyLight, SoulMateColors.skyDeep],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("SoulMate Kids",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60)),
              const SizedBox(height: 20),
              _buildPuffyTitle(),
              const Spacer(),
              // Neşeli Narval
              CharacterCard(
                  name: "Neşeli Narval",
                  emoji: "🐳",
                  color: SoulMateColors.narvalGlow,
                  onTap: () => _navigateToEmotion(
                      context,
                      "🐳",
                      "Neşeli Narval",
                      "okyanus_bg.png",
                      SoulMateColors.narvalGlow)),
              const SizedBox(height: 30),
              // Zeki Tilki
              CharacterCard(
                  name: "Zeki Tilki",
                  emoji: "🦊",
                  color: SoulMateColors.tilkiGlow,
                  onTap: () => _navigateToEmotion(context, "🦊", "Zeki Tilki",
                      "orman_bg.png", SoulMateColors.tilkiGlow)),
              const SizedBox(height: 30),
              // Bilge Baykuş
              CharacterCard(
                  name: "Bilge Baykuş",
                  emoji: "🦉",
                  color: SoulMateColors.baykusGlow,
                  onTap: () => _navigateToEmotion(context, "🦉", "Bilge Baykuş",
                      "gece_bg.png", SoulMateColors.baykusGlow)),
              const Spacer(),
              const Text("Bir arkadaş seç ve maceraya başla!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Burası kritik! Seçilen ismi bir sonraki ekrana taşıyoruz.
  void _navigateToEmotion(
      BuildContext context, String emoji, String name, String bg, Color color) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmotionSelectionScreen(
          emoji: emoji,
          name: name, // Bu isim backend'e gidecek!
          bgImage: bg,
          themeColor: color,
        ),
      ),
    );
  }

  Widget _buildPuffyTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Text(
        "Haydi bir arkadaş seçelim! ✨",
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 8)
            ]),
      ),
    );
  }
}
