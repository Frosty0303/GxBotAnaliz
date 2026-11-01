import 'package:flutter/material.dart';

class AnalizDetaySayfasi extends StatelessWidget {
  final String evSahibi;
  final String deplasman;
  final String lig;

  const AnalizDetaySayfasi({
    super.key,
    required this.evSahibi,
    required this.deplasman,
    required this.lig,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$evSahibi vs $deplasman'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Maç ve Lig Bilgisi Kartı
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lig, style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('$evSahibi - $deplasman', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Icon(Icons.analytics, color: Colors.greenAccent, size: 36),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Yapay Zeka Skor ve Oran Tahminleri Başlığı
            const Text('🤖 GX Yapay Zeka Analiz Raporu', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Tahminler Grid Yapısı
            Row(
              children: [
                Expanded(child: _buildTahminKarti('Olası Skor', '2 - 1', Colors.blueGrey)),
                const SizedBox(width: 10),
                Expanded(child: _buildTahminKarti('KG Var', '%72', Colors.green)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildTahminKarti('2.5 Üst', '%65', Colors.orange)),
                const SizedBox(width: 10),
                Expanded(child: _buildTahminKarti('Güven Skoru', '8.5 / 10', Colors.purple)),
              ],
            ),
            const SizedBox(height: 20),

            // Detaylı AI Yorumu
            const Text('Maçın Detaylı Yorumu', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
              ),
              child: const Text(
                'Ev sahibi takımın iç sahadaki baskılı oyunu ve hücum hattının form durumu ön planda. Konuk ekibin savunmasında kilit oyuncuların eksik olması, maçın gidişatını etkileyecek en önemli faktör. Karşılıklı gol ihtimali yüksek görünüyor.',
                style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),

            // Bilgilendirme Notu (Oynama barındırmadığını vurgulayan)
            const Center(
              child: Text(
                '⚠️ Bu uygulama yalnızca istatistiksel analiz ve yapay zeka veri rehberidir. Bahis veya şans oyunu barındırmaz.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTahminKarti(String baslik, String deger, Color renk) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: renk.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(baslik, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(deger, style: TextStyle(color: renk, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
