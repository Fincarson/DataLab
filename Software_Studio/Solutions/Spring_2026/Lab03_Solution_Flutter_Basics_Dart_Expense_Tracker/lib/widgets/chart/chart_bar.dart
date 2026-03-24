import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  ChartBar({super.key, required this.fill, required this.icon});

  final double fill;
  final IconData icon;

  // Bar
  Widget buildBar(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: fill,
          widthFactor: 1.0,
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.45),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Category
  Widget buildCategoryIcon(BuildContext context){
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // Build
  @override
  Widget build(BuildContext context){
    return Column(
      children:[
        Expanded(child: buildBar(context)),
        const SizedBox(height: 12),
        buildCategoryIcon(context),
      ],
    );
  }
}