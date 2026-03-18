import 'package:flutter/material.dart';
import 'package:test_dart/models/expense.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses;

  const Chart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    double totalAmount = expenses.fold(0, (sum, item) => sum + item.amount);

    Map<Category, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: Category.values.map((category) {
            double amount = categoryTotals[category] ?? 0;
            double fillPercentage = totalAmount == 0 ? 0 : amount / totalAmount;

            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: fillPercentage,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        //width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryFixedDim,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(_getCategoryIcon(category), color: Theme.of(context).colorScheme.onPrimaryContainer),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.lunch_dining;
      case Category.leisure:
        return Icons.movie;
      case Category.travel:
        return Icons.flight_takeoff;
      case Category.work:
        return Icons.work;
      default:
        return Icons.help_outline;
    }
  }
}
