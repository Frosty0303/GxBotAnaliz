import 'package:flutter/material.dart';
import 'analiz_sayfasi.dart'; // Analiz sayfamızı buraya bağlıyoruz

void main() => runApp(const AnalizApp());

class AnalizApp extends StatelessWidget {
  const AnalizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GX Maç Analiz',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF1B5E20),
      ),
      home: const AnaEkran(),
    );
  }
}

class AnaEkran extends StatelessWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GX - Yapay Zeka Maç Analizleri'),
          backgroundColor: const Color(0xFF1F1F1F),
          bottom: const TabBar(
            indicatorColor: Color(0xFF4CAF50),
            tabs: [
              Tab(text: 'Canlı'),
              Tab(text: 'Günün Maçları'),
              Tab(text: 'Gelecek Maçlar'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MacListesi(durum: 'Canlı'),
            MacListesi(durum: 'Bugun'),
            MacListesi(durum: 'Gelecek'),
          ],
        ),
      ),
    );
  }
}

class MacListesi extends StatelessWidget {
  final String durum;
  const MacListesi({super.key, required this.durum});

  @override
  Widget build(BuildContext context) {
    final maclar = [
      {'lig': 'Türkiye Süper Lig', 'ev': 'Galatasaray', 'dep': 'Fenerbahçe', 'saat': '20:00', 'skor': durum == 'Canlı' ? '1 - 0' : 'VS'},
      {'lig': 'İngiltere Premier Lig', 'ev': 'Arsenal', 'dep': 'Manchester City', 'saat': '22:30', 'skor': durum == 'Canlı' ? '2 - 2' : 'VS'},
    ];

    return ListView.builder(
      itemCount: maclar.length,
      itemBuilder: (context, index) {
        final mac = maclar[index];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            leading: Text(mac['saat']!, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            title: Text('${mac['ev']} vs ${mac['dep']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(mac['lig']!, style: const TextStyle(color: Colors.grey)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(mac['skor']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              // Maça tıklandığında doğrudan GX Yapay Zeka Analiz Sayfası açılır!
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalizDetaySayfasi(
                    evSahibi: mac['ev']!,
                    deplasman: mac['dep']!,
                    lig: mac['lig']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
