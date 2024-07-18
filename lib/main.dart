import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_tracking_page.dart';
import 'expense_categorization_page.dart';
import 'savings_goals_page.dart';
import 'financial_tips_page.dart';
import 'bill_reminders_page.dart';
import 'debt_management_page.dart';
import 'data_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Savings',
      theme: ThemeData(
      primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color(0xFFA3CEF1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF274C77),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Savings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHomePageButton(context, 'Budget Tracking', Icons.track_changes, BudgetTrackingPage()),
          _buildHomePageButton(context, 'Expense Categorization', Icons.category, const ExpenseCategorizationPage()),
          _buildHomePageButton(context, 'Savings Goals', Icons.savings, const SavingsGoalsPage()),
          _buildHomePageButton(context, 'Financial Tips', Icons.lightbulb, const FinancialTipsPage()),
          _buildHomePageButton(context, 'Bill Reminders', Icons.notifications, const BillRemindersPage()),
          _buildHomePageButton(context, 'Debt Management', Icons.money_off, const DebtManagementPage()),
        ],
      ),
    );
  }

  Widget _buildHomePageButton(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Theme.of(context).cardColor,
      child: InkWell(
        splashColor: const Color(0xFF6096BA),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40.0, color: const Color(0xFF274C77)),
              const SizedBox(height: 8.0),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF274C77))),
            ],
          ),
        ),
      ),
    );
  }
}
