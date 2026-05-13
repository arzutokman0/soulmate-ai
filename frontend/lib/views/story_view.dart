import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoryView extends StatefulWidget {
  final String emoji;
  final String name;
  final String emotion;
  final Color themeColor;

  const StoryView({
    super.key,
    required this.emoji,
    required this.name,
    required this.emotion,
    required this.themeColor,
  });

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  String _generatedStory = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStoryFromAI();
  }

  Future<void> _fetchStoryFromAI() async {
    try {
      // KRİTİK DEĞİŞİKLİK: Chrome (Web) üzerinden bağlandığın için 'localhost' kullanıyoruz
      final response = await http.post(
        Uri.parse(
            'http://localhost:8000/generate-story'), // Burayı güncelledik ✨
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "character": widget.name,
          "emotion": widget.emotion,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _generatedStory = data['story'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _generatedStory =
              "Hay aksi! Masal perileri yolda biraz gecikti. Lütfen tekrar dene.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _generatedStory =
            "Bağlantı kurulamadı. Sunucun (uvicorn) açık mı balım?";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeColor.withOpacity(0.1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text("${widget.name} ile Masal Saati",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const Spacer(),
            Hero(
              tag: 'character_bubble',
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: widget.themeColor.withOpacity(0.3),
                        blurRadius: 30)
                  ],
                ),
                child: Center(
                    child: Text(widget.emoji,
                        style: const TextStyle(fontSize: 100))),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 20)
                  ],
                ),
                child: _isLoading
                    ? Center(
                        child:
                            CircularProgressIndicator(color: widget.themeColor),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Sen bugün ${widget.emotion} hissediyorsun diye bu masalı senin için hazırladım: ✨",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _generatedStory,
                              style: const TextStyle(
                                  fontSize: 20,
                                  height: 1.6,
                                  color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FloatingActionButton.large(
                onPressed: _isLoading
                    ? null
                    : () {
                        // TTS (Sesli Okuma) buraya gelecek
                      },
                backgroundColor: _isLoading ? Colors.grey : widget.themeColor,
                child:
                    const Icon(Icons.play_arrow, size: 50, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
