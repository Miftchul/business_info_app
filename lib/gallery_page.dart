import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<String> _videoPaths = [
    'assets/videos/video1.mp4',
    'assets/videos/video2.mp4',
    'assets/videos/video3.mp4',
  ];
  final List<VideoPlayerController> _controllers = [];
  int _currentIndex = 0;

  final List<Map<String, String>> _galleryItems = const [
    {
      'imagePath': 'assets/images/business1.png',
      'description': 'Deskripsi singkat tentang gambar sains/teknologi 1.',
    },
    {
      'imagePath': 'assets/images/business2.png',
      'description': 'Deskripsi singkat tentang gambar sains/teknologi 2.',
    },
    {
      'imagePath': 'assets/images/business3.png',
      'description': 'Deskripsi singkat tentang gambar teknologi 1.',
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var path in _videoPaths) {
      final controller = VideoPlayerController.asset(path);
      controller.initialize().then((_) {
        setState(() {});
      });
      _controllers.add(controller);
    }
    if (_controllers.isNotEmpty) {
      _controllers[0].play();
      _controllers[0].setLooping(true);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    if (_controllers[_currentIndex].value.isPlaying) {
                      _controllers[_currentIndex].pause();
                    }
                    setState(() {
                      _currentIndex = index;
                    });
                    _controllers[_currentIndex].play();
                    _controllers[_currentIndex].setLooping(true);
                  },
                ),
                items: _controllers.map((controller) {
                  return Builder(
                    builder: (BuildContext context) {
                      return controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            )
                          : Container(
                              height: 200.0,
                              color: Colors.grey[300],
                              child: const Center(child: CircularProgressIndicator()),
                            );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _galleryItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        item['imagePath']!,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item['description']!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _galleryItems.length,
            ),
          ),
        ],
      ),
    );
  }
}