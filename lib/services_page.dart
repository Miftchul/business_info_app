import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  final List<Map<String, String>> _servicesAndProducts = const [
    {
      'type': 'Layanan',
      'title': 'Konsultasi Masalah Teknologi',
      'description': 'Sesi konsultasi mendalam untuk membantu Anda mengatasi berbagai tantangan teknologi dalam bisnis Anda.',
    },
    {
      'type': 'Layanan',
      'title': 'Konsultasi Bisnis',
      'description': 'Panduan ahli untuk mengembangkan strategi bisnis yang efektif dan mencapai tujuan Anda.',
    },
    {
      'type': 'Layanan',
      'title': 'Konsultasi Perpajakan',
      'description': 'Solusi perpajakan yang komprehensif untuk memastikan kepatuhan dan efisiensi finansial bisnis Anda.',
    },
    {
      'type': 'Jasa',
      'title': 'Pembuatan Website',
      'description': 'Desain dan pengembangan website profesional yang menarik dan responsif untuk berbagai kebutuhan bisnis.',
    },
    {
      'type': 'Jasa',
      'title': 'Pembuatan Aplikasi',
      'description': 'Pengembangan aplikasi mobile (Android/iOS) yang inovatif dan sesuai dengan kebutuhan spesifik Anda.',
    },
    {
      'type': 'Jasa',
      'title': 'AI Agent',
      'description': 'Pengembangan dan implementasi AI Agent cerdas untuk mengotomatisasi tugas dan meningkatkan efisiensi operasional.',
    },
    {
      'type': 'Produk',
      'title': 'Template Notion',
      'description': 'Berbagai template Notion siap pakai untuk meningkatkan produktivitas dan organisasi bisnis Anda.',
    },
    {
      'type': 'Produk',
      'title': 'Dashboard',
      'description': 'Solusi dashboard interaktif untuk visualisasi data bisnis yang jelas dan pengambilan keputusan yang tepat.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan & Produk Kami'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _servicesAndProducts.length,
        itemBuilder: (context, index) {
          final item = _servicesAndProducts[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    item['type']!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    item['description']!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk menghubungi atau melihat detail lebih lanjut
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tertarik dengan ${item['title']}? Hubungi kami!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const Text('Pelajari Lebih Lanjut'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}