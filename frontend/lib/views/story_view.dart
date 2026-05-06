import 'package:flutter/material.dart';

class StoryView extends StatefulWidget {
  final String emoji;
  final String name;
  final String emotion; // Çocuğun seçtiği duygu (Mutlu, Üzgün vb.)
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
  // Şimdilik örnek bir masal metni, ileride burayı AI (FastAPI) besleyecek
  final String _sampleStory =
      "Bir varmış, bir yokmuş... Gökyüzünün en parlak yıldızının altında, senin gibi tatlı bir çocuk yaşarmış. Bugün seninle birlikte sihirli bir yolculuğa çıkacağız...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.themeColor.withOpacity(0.1), // Arka plana hafif bir renk tonu
      body: SafeArea(
        child: Column(
          children: [
            // ÜST BAR: Geri butonu ve başlık
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
                  const SizedBox(width: 40), // Dengelemek için boşluk
                ],
              ),
            ),

            // KARAKTER ALANI: Masalı anlatan arkadaşımız
            const Spacer(),
            Hero(
              tag: 'character_hero', // Küçük bir geçiş animasyonu için
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

            // MASAL KUTUSU: Metnin akacağı yer
            Expanded(
              flex: 3,
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
                child: SingleChildScrollView(
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
                        _sampleStory,
                        style: const TextStyle(
                            fontSize: 20, height: 1.6, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ALT BUTONLAR: Dinle, Durdur, İlerle gibi
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FloatingActionButton.large(
                onPressed: () {
                  // İleride buraya Sesli Okuma (TTS) gelecek
                },
                backgroundColor: widget.themeColor,
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
