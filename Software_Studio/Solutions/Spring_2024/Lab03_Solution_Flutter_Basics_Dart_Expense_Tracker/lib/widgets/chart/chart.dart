import 'package:flutter/material.dart';

import 'package:test_dart/models/expense.dart';
import 'package:test_dart/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget{
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> buildBuckets(){
    return[
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  // Find Max
  double findMaxBucketTotal(List<ExpenseBucket> buckets){
    if(buckets.isEmpty) return 0;

    return buckets.fold(
      0.0, (maxValue, bucket) => bucket.totalExpenses > maxValue ? bucket.totalExpenses : maxValue,
    );
  }

  // Create the Bars
  List<Widget> chartBars(List<ExpenseBucket> buckets, double maxTotal){
    return buckets.map(
      (bucket) => Expanded(
        child: ChartBar(
          fill: maxTotal == 0 ? 0 : bucket.totalExpenses / maxTotal,
          icon: categoryIcons[bucket.category]!,
        ),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context){
    final buckets = buildBuckets();
    final maxTotal = findMaxBucketTotal(buckets);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              colorScheme.secondaryContainer.withOpacity(0.55),
              colorScheme.secondaryContainer.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: chartBars(buckets, maxTotal)
        ),
      ),
    );
  }
}