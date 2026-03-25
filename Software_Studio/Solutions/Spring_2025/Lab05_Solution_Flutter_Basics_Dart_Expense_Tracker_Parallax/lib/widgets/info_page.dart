import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.add,
      'title': 'Press Add button at the upper-right corner to track a new expense.',
      'button': 'Next',
    },
    {
      'icon': Icons.swipe,
      'title': 'Swipe a tracked expense left or right to delete it.',
      'button': 'Done',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Info')),
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        pageSnapping: true, // Ensure snapping behavior is enabled
        physics: ClampingScrollPhysics(), // Makes the scroll smoother and more predictable
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double pageOffset = 0;
              if (_controller.hasClients && _controller.position.haveDimensions) {
                pageOffset = _controller.page! - index;
              }

              return _ParallaxInfoScreen(
                icon: _pages[index]['icon'],
                title: _pages[index]['title'],
                buttonText: _pages[index]['button'],
                //offset: (_controller.hasClients && _controller.page != null) ? pageOffset: 0.0,
                offset: pageOffset,

                color: Colors.white,
                controller: _controller,
                isLastPage: index == _pages.length - 1,
              );
            },
          );
        },
      ),
    );
  }
}

class _ParallaxInfoScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String buttonText;
  final double offset;
  final PageController controller;
  final bool isLastPage;
  final Color color;

  const _ParallaxInfoScreen({
    required this.icon,
    required this.title,
    required this.buttonText,
    required this.offset,
    required this.controller,
    required this.isLastPage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(offset * 1.5, 0), // icon move at 1.5x speed
                child: Icon(icon, size: 80, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: Offset(offset * 50 * 1.5, 0), // text move at 1.5x speed
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 30),
              Transform.translate(
                offset: Offset(offset * 90 * 2.5, 0), // button move at 2.5x speed
                child: ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.of(context).pop(); // or navigate to home screen
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
