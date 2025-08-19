import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String) deleteExpense;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.deleteExpense,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Travel':
        return Icons.flight_takeoff;
      case 'Shopping':
        return Icons.shopping_cart;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.hourglass_empty, size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'No expenses added yet!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    )
        : ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final exp = expenses[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                _getCategoryIcon(exp.category),
                color: Colors.white,
              ),
            ),
            title: Text(
              exp.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              '${exp.category} • ${exp.date.toLocal().toString().split(' ')[0]}',
            ),
            trailing: Text(
              '\$${exp.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            onLongPress: () => deleteExpense(exp.id),
          ),
        );
      },
    );
  }
}
