import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_list.dart';
import '../widgets/new_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _addExpense(String title, double amount, DateTime date, String category) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((exp) => exp.id == id);
    });
  }

  void _openAddExpenseModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewExpense(addExpense: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openAddExpenseModal(context),
          ),
        ],
      ),
      body: ExpenseList(expenses: _expenses, deleteExpense: _deleteExpense),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddExpenseModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
