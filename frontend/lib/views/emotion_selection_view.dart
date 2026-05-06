import 'story_view.dart';
import 'package:flutter/material.dart';

class EmotionSelectionScreen extends StatelessWidget {
  final String emoji;
  final String name;
  final String bgImage;
  final Color themeColor;

  const EmotionSelectionScreen(
      {super.key,
      required this.emoji,
      required this.name,
      required this.bgImage,
      required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/$bgImage"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Container(color: Colors.black.withOpacity(0.15)),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  // Karakteri Hero ile sarmaladık (geçiş animasyonu için)
                  Hero(
                    tag: 'character_bubble',
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                              color: themeColor.withOpacity(0.7),
                              blurRadius: 40,
                              spreadRadius: 5),
                        ],
                      ),
                      child: Center(
                          child: Text(emoji,
                              style: const TextStyle(
                                  fontSize: 110,
                                  decoration: TextDecoration.none))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSpeechBubble(),
                  const Spacer(),
                  // DİKKAT: Buraya 'context' parametresini ekledik!
                  _buildEmotionRow(context),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeechBubble() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 15)],
      ),
      child: Text(
        "Merhaba! Ben $name. Bugün seninle bu macerada olduğum için çok heyecanlıyım. Şu an nasıl hissediyorsun?",
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            decoration: TextDecoration.none),
      ),
    );
  }

  Widget _buildEmotionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Başına 'context,' eklemeyi unutma!
        _emotionCircle(context, "Mutlu", "😊"),
        _emotionCircle(context, "Üzgün", "😢"),
        _emotionCircle(context, "Heyecanlı", "🤩"),
      ],
    );
  }

  Widget _emotionCircle(BuildContext context, String label, String emo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryView(
              emoji: emoji,
              name: name,
              emotion: label,
              themeColor: themeColor,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Text(emo,
                style: const TextStyle(
                    fontSize: 45, decoration: TextDecoration.none)),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 8)])),
        ],
      ),
    );
  }
}
