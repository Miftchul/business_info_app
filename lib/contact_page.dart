import 'package:flutter/material.dart';
import 'dart:math';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), // Satu siklus penuh untuk animasi
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Kami'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: SolarSystemPainter(_controller.value),
                child: Container(),
              );
            },
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                      fontFamily: 'Fantasy',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.location_on, color: Colors.deepPurple, size: 32.0),
                            title: const Text(
                              'Alamat',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                            subtitle: const Text(
                              'Sukun, Kota Malang, Jawa Timur',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.phone, color: Colors.deepPurple, size: 32.0),
                            title: const Text(
                              'Nomor Telepon',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                            subtitle: const Text(
                              '0877-1111-2222',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.email, color: Colors.deepPurple, size: 32.0),
                            title: const Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.deepPurple,
                              ),
                            ),
                            subtitle: const Text(
                              'example@gmail.com',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SolarSystemPainter extends CustomPainter {
  final double animationValue;
  final Paint planetPaint = Paint()..style = PaintingStyle.fill;
  final Paint orbitPaint = Paint()
    ..color = Colors.white.withOpacity(0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  final Paint sunPaint = Paint()..style = PaintingStyle.fill;

  SolarSystemPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw background
    final Gradient backgroundGradient = RadialGradient(
      colors: [Colors.black, Colors.deepPurple.shade900],
      center: Alignment.center,
      radius: 0.7,
    );
    final backgroundPaint = Paint()
      ..shader = backgroundGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw Sun
    const double sunRadius = 30;
    final RadialGradient sunGradient = RadialGradient(
      colors: [Colors.yellowAccent, Colors.orangeAccent, Colors.deepOrange],
      center: Alignment.center,
      radius: 0.8,
    );
    sunPaint.shader = sunGradient.createShader(Rect.fromCircle(center: center, radius: sunRadius));
    canvas.drawCircle(center, sunRadius, sunPaint);

    // Add subtle glow to the sun
    final sunGlowPaint = Paint()
      ..color = Colors.yellow.withOpacity(0.3 + 0.2 * sin(animationValue * 2 * pi))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 20);
    canvas.drawCircle(center, sunRadius + 10, sunGlowPaint);

    // Define planets
    final planets = [
      Planet(name: 'Merkurius', radius: 8, color: Colors.grey, orbitRadius: 40, speed: 4.74),
      Planet(name: 'Venus', radius: 15, color: Colors.orangeAccent, orbitRadius: 70, speed: 3.50),
      Planet(name: 'Bumi', radius: 16, color: Colors.blue, orbitRadius: 100, speed: 2.98),
      Planet(name: 'Mars', radius: 12, color: Colors.redAccent, orbitRadius: 150, speed: 2.41),
      Planet(name: 'Jupiter', radius: 40, color: Colors.orange, orbitRadius: 220, speed: 1.31),
      Planet(name: 'Saturnus', radius: 35, color: Colors.amber, orbitRadius: 300, speed: 0.97),
      Planet(name: 'Uranus', radius: 25, color: Colors.lightBlueAccent, orbitRadius: 380, speed: 0.68),
      Planet(name: 'Neptunus', radius: 24, color: Colors.indigoAccent, orbitRadius: 450, speed: 0.54),
    ];

    // Draw orbits and planets
    for (final planet in planets) {
      // Draw orbit
      canvas.drawCircle(center, planet.orbitRadius, orbitPaint);

      // Calculate planet position
      final angle = animationValue * 2 * pi * planet.speed / planets[2].speed; // Kecepatan relatif ke Bumi
      final planetX = center.dx + planet.orbitRadius * cos(angle);
      final planetY = center.dy + planet.orbitRadius * sin(angle);
      final planetOffset = Offset(planetX, planetY);

      // Draw planet
      planetPaint.color = planet.color;
      canvas.drawCircle(planetOffset, planet.radius, planetPaint);

      // Add subtle shadow (simplified)
      final shadowOffset = Offset(planetOffset.dx + 3, planetOffset.dy + 3);
      final shadowPaint = Paint()..color = Colors.black.withOpacity(0.3);
      canvas.drawCircle(shadowOffset, planet.radius * 0.9, shadowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SolarSystemPainter oldDelegate) => true;
}

class Planet {
  final String name;
  final double radius;
  final Color color;
  final double orbitRadius;
  final double speed;

  Planet({
    required this.name,
    required this.radius,
    required this.color,
    required this.orbitRadius,
    required this.speed,
  });
}