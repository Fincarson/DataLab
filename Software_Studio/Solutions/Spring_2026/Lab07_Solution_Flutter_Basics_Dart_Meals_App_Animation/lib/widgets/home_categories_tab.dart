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
    //_animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _animationController.forward();
    });
  }

  @override
  // Bruh
  void didUpdateWidget(covariant HomeCategoriesTab old){
    super.didUpdateWidget(old);
    _animationController.forward(from: 0);
  }
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goMealsOnCategory(categoryId: category.id);
  }

  

  @override
  Widget build(BuildContext context){
    final categories = dummyCategories.values.toList();
    const itemsPerRow = 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemsPerRow,
        childAspectRatio: 3/2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        final rowIndex = index ~/ itemsPerRow;
        final totalRows = (categories.length / itemsPerRow).ceil();

        final animation = Tween<Offset>(
          begin: const Offset(0, 10.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              (rowIndex/totalRows).clamp(0.0, 1.0),
              (rowIndex/totalRows + 2.0).clamp(0.0, 1.0),
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

  //Hint: Maybe modify here? Bruhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
  // @override
  // Widget build(BuildContext context) {
  //   return SlideTransition(
  //     position: Tween(
  //       begin: const Offset(0, 0.7),
  //       end: const Offset(0, 0),
  //     ).animate(
  //       CurvedAnimation(
  //         parent: _animationController,
  //         curve: Curves.easeOutCubic,
  //       ),
  //     ),
  //     child: GridView(
  //       padding: const EdgeInsets.all(16),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: 3 / 2,
  //         crossAxisSpacing: 16,
  //         mainAxisSpacing: 16,
  //       ),
  //       children: [
  //         // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
  //         for (final category in dummyCategories.values)
  //           CategoryGridItem(
  //             category: category,
  //             onSelectCategory: () {
  //               _selectCategory(context, category);
  //             },
  //           )
  //       ],
  //     ),
  //   );
  // }
}
