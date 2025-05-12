import 'package:flutter/material.dart';

class OperatingHoursPage extends StatelessWidget {
  const OperatingHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Jam Operasional',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'Senin - Jumat:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('[Jam Buka - Jam Tutup]'), // Ganti dengan jam operasional Senin-Jumat Anda
          SizedBox(height: 8.0),
          Text(
            'Sabtu:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('[Jam Buka - Jam Tutup] (Opsional)'), // Ganti dengan jam operasional Sabtu Anda, atau hapus jika tutup
          SizedBox(height: 8.0),
          Text(
            'Minggu:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('[Jam Buka - Jam Tutup] (Opsional)'), // Ganti dengan jam operasional Minggu Anda, atau hapus jika tutup
          SizedBox(height: 16.0),
          Text(
            'Catatan Tambahan (Opsional):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('[Catatan tambahan mengenai jam operasional, misalnya tutup pada hari libur tertentu]'), // Tambahkan catatan jika perlu
        ],
      ),
    );
  }
}