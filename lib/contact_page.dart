import 'package:flutter/material.dart';
import 'dart:math';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _points;
  Offset? _cursorPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Generate random points for the animation
    _points = List.generate(50, (index) {
      final random = Random();
      return Offset(random.nextDouble(), random.nextDouble());
    });
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
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _cursorPosition = event.localPosition;
          });
        },
        onExit: (_) {
          setState(() {
            _cursorPosition = null;
          });
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: NetworkPainter(_points, _cursorPosition, _controller.value),
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
      ),
    );
  }
}

class NetworkPainter extends CustomPainter {
  final List<Offset> points;
  final Offset? cursorPosition;
  final double animationValue;

  NetworkPainter(this.points, this.cursorPosition, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.7)
      ..strokeWidth = 1.0;

    final pointPaint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;

    // Draw points
    for (final point in points) {
      final dx = point.dx * size.width;
      final dy = point.dy * size.height;
      canvas.drawCircle(Offset(dx, dy), 3.0, pointPaint);

      // Draw lines between points
      for (final otherPoint in points) {
        final otherDx = otherPoint.dx * size.width;
        final otherDy = otherPoint.dy * size.height;
        final distance = (Offset(dx, dy) - Offset(otherDx, otherDy)).distance;
        if (distance < 100) {
          paint.color = Colors.lightBlue.withOpacity(1 - (distance / 100));
          canvas.drawLine(Offset(dx, dy), Offset(otherDx, otherDy), paint);
        }
      }

      // Draw lines to cursor
      if (cursorPosition != null) {
        final distanceToCursor = (Offset(dx, dy) - cursorPosition!).distance;
        if (distanceToCursor < 150) {
          paint.color = Colors.lightBlue.withOpacity(1 - (distanceToCursor / 150));
          canvas.drawLine(Offset(dx, dy), cursorPosition!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}