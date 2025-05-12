import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Tambahkan logo bisnis Anda di sini (jika ada)
          Image.asset('assets/images/logo.png'), // Pastikan path ini benar
          const SizedBox(height: 20.0),
          const Text(
            'Selamat Datang di MiftTech!', // Ganti dengan nama bisnis Anda
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Kami menyediakan solusi teknologi inovatif untuk membantu bisnis Anda tumbuh dan berkembang. Dengan layanan terbaik dan teknologi terkini, kami siap mendukung kebutuhan digital Anda.', // Ganti dengan deskripsi bisnis Anda
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}