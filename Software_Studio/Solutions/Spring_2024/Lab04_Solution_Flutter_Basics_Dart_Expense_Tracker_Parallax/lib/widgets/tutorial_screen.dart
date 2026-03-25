import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToSecondPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _closeTutorial() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial'),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            TutorialPage(
              controller: _pageController,
              pageIndex: 0,
              icon: Icons.add_circle_outline,
              title: 'Add your expenses',
              description:'Tap the + button to create a new expense entry and keep your spending organized.',
              buttonText: 'Next',
              onPressed: _goToSecondPage,
            ),
            TutorialPage(
              controller: _pageController,
              pageIndex: 1,
              icon: Icons.swipe_outlined,
              title: 'Manage with ease',
              description: 'Swipe expense items to remove them, and use the chart to quickly understand where your money goes.',
              buttonText: 'Got it',
              onPressed: _closeTutorial,
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  const TutorialPage({
    super.key,
    required this.controller,
    required this.pageIndex,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  final PageController controller;
  final int pageIndex;
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  double _getCurrentPage() {
    if (!controller.hasClients) {return controller.initialPage.toDouble();}
    return controller.page ?? controller.initialPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final screenWidth = constraints.maxWidth;

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final currentPage = _getCurrentPage();
            final pageOffset = currentPage - pageIndex;
            final iconDx = -pageOffset * screenWidth * 0.25; // 1 + 0.25 = 1.25
            final textDx = -pageOffset * screenWidth * 0.5; // 1 + 0.5 = 1.5
            final buttonDx = -pageOffset * screenWidth * 1.5; // 1 + 1.5 = 2.5

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  Transform.translate(
                    offset: Offset(iconDx, 0),
                    child: Icon(
                      icon,
                      size: 96,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Transform.translate(
                    offset: Offset(textDx, 0),
                    child: Text(
                      title,
                      style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold,),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Transform.translate(
                    offset: Offset(textDx, 0),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  const Spacer(),

                  Transform.translate(
                    offset: Offset(buttonDx, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(buttonText),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}