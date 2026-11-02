
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'analiz_sayfasi.dart';

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

class MacListesi extends StatefulWidget {
  final String durum;
  const MacListesi({super.key, required this.durum});

  @override
  State<MacListesi> createState() => _MacListesiState();
}

class _MacListesiState extends State<MacListesi> {
  List<dynamic> maclar = [];
  bool yukleniyor = true;

  @override
  void initState() {
    super.initState();
    maclariGetir();
  }

  Future<void> maclariGetir() async {
    try {
      // Ücretsiz ve açık spor veri kaynaklarından örnek maç akışı
      final response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/3/eventsday.php?d=2026-03-30&s=Soccer'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          maclar = data['events'] ?? [];
          yukleniyor = false;
        });
      } else {
        setState(() {
          yukleniyor = false;
        });
      }
    } catch (e) {
      setState(() {
        yukleniyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (yukleniyor) {
      return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
    }

    if (maclar.isEmpty) {
      // API'den veri gelmezse veya yedek olarak akıllı örnek liste gösterimi
      final yedekMaclar = [
        {'lig': 'Türkiye Süper Lig', 'ev': 'Galatasaray', 'dep': 'Fenerbahçe', 'saat': '20:00', 'skor': widget.durum == 'Canlı' ? '1 - 0' : 'VS'},
        {'lig': 'İngiltere Premier Lig', 'ev': 'Arsenal', 'dep': 'Manchester City', 'saat': '22:30', 'skor': widget.durum == 'Canlı' ? '2 - 2' : 'VS'},
        {'lig': 'İspanya La Liga', 'ev': 'Real Madrid', 'dep': 'Barcelona', 'saat': '23:00', 'skor': widget.durum == 'Canlı' ? '0 - 0' : 'VS'},
      ];

      return ListView.builder(
        itemCount: yedekMaclar.length,
        itemBuilder: (context, index) {
          final mac = yedekMaclar[index];
          return _buildMacKarti(context, mac['ev']!, mac['dep']!, mac['lig']!, mac['saat']!, mac['skor']!);
        },
      );
    }

    return ListView.builder(
      itemCount: maclar.length,
      itemBuilder: (context, index) {
        final mac = maclar[index];
        final ev = mac['strHomeTeam'] ?? 'Ev Sahibi';
        final dep = mac['strAwayTeam'] ?? 'Deplasman';
        final lig = mac['strLeague'] ?? 'Futbol Ligi';
        final saat = mac['strTime'] ?? '21:00';
        final skor = widget.durum == 'Canlı' ? '${mac['intHomeScore'] ?? '0'} - ${mac['intAwayScore'] ?? '0'}' : 'VS';

        return _buildMacKarti(context, ev, dep, lig, saat, skor);
      },
    );
  }

  Widget _buildMacKarti(BuildContext context, String ev, String dep, String lig, String saat, String skor) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Text(saat, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        title: Text('$ev vs $dep', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(lig, style: const TextStyle(color: Colors.grey)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(skor, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnalizDetaySayfasi(
                evSahibi: ev,
                deplasman: dep,
                lig: lig,
              ),
            ),
          );
        },
      ),
    );
  }
}
