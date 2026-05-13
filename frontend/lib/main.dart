import 'package:flutter/material.dart';
import 'views/character_selection_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Doğru JSON kütüphanesi budur

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
        fontFamily: 'Comic Sans MS', // Pofuduk bir font seçimi!
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      // Uygulama senin tasarladığın karakter seçme ekranıyla açılıyor
      home: const CharacterSelectionScreen(),
    );
  }
}

// Backend ile konuşacak olan fonksiyonu buraya veya
// CharacterSelectionScreen içindeki butona ekleyeceğiz.
Future<String> getStoryFromBackend(String character, String emotion) async {
  try {
    // Android emülatör kullanıyorsan 10.0.2.2, iOS veya gerçek cihazsa kendi IP'ni yazmalısın
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/generate-story'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "character": character,
        "emotion": emotion,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['story']; // Backend'den gelen o pofuduk masal
    } else {
      return "Masal perileri yolda biraz gecikti, tekrar dener misin?";
    }
  } catch (e) {
    return "Backend'e ulaşılamadı. Sunucun (uvicorn) açık mı balım?";
  }
}
