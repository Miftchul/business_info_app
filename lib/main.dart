import 'package:flutter/material.dart';
import 'contact_page.dart';
import 'operating_hours_page.dart';
import 'gallery_page.dart';
import 'services_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Text('Beranda'), // Replace HomePage with a simple widget
    ContactPage(),
    OperatingHoursPage(),
    GalleryPage(),
    ServicesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiftTech'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Kontak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jam Buka',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Galeri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Layanan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: HomePage()));
}