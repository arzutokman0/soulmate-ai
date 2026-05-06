import 'package:flutter/material.dart';

class CharacterCard extends StatefulWidget {
  final String name;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.name,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  double _scale = 1.0; // Başlangıç boyutu

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Elini bastığında küçülsün (basılma hissi)
      onTapDown: (_) => setState(() => _scale = 0.9),
      // Elini çektiğinde eski boyuna dönsün
      onTapUp: (_) => setState(() => _scale = 1.0),
      // Tıklama gerçekleştiğinde
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOutBack, // Hafif zıplama efekti verir
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: widget.color.withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 5),
                ],
              ),
              child: Center(
                  child:
                      Text(widget.emoji, style: const TextStyle(fontSize: 85))),
            ),
            const SizedBox(height: 10),
            Text(widget.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
