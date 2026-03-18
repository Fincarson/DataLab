import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  const ChartBar({super.key, required this.fill, required this.icon});

  final double fill;
  final IconData icon;

  Widget buildBar(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: fill,
          widthFactor: 0.9,
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.45),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryIcon(BuildContext context){
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // Build
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(child: buildBar(context)),
        const SizedBox(height: 12),
        buildCategoryIcon(context),
      ]
    );
  }
}