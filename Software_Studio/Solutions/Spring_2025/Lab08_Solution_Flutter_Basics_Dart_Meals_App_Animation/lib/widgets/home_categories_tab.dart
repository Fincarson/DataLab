import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lab08/data/dummy_data.dart';
import 'package:lab08/models/category.dart';
import 'package:lab08/services/navigation.dart';
import 'package:lab08/widgets/category_grid_item.dart';

class HomeCategoriesTab extends StatefulWidget {
  const HomeCategoriesTab({super.key});

  @override
  State<HomeCategoriesTab> createState() => _HomeCategoriesTabState();
}

class _HomeCategoriesTabState extends State<HomeCategoriesTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // _animationController.forward();

    // Delay animation until after first frame to prevent initial skip
    // Delay animation until after first frame to prevent initial skip
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void didUpdateWidget(covariant HomeCategoriesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.forward(from: 0); // Restart when tab is revisited
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goMealsOnCategory(categoryId: category.id);
  }

  @override
  Widget build(BuildContext context) {
    final categories = dummyCategories.values.toList();
    const itemsPerRow = 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsPerRow,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        // Group index by row
        final rowIndex = index ~/ itemsPerRow;
        final totalRows = (categories.length / itemsPerRow).ceil();

        final animation = Tween<Offset>(
          begin: const Offset(0, 5.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              (rowIndex / totalRows).clamp(0.0, 1.0),
              //((rowIndex + 1) / totalRows).clamp(0.0, 1.0),
              (rowIndex / totalRows + 0.6).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          ),
        );

        return SlideTransition(
          position: animation,
          child: CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(context, category),
          ),
        );
      },
    );
  }

}
