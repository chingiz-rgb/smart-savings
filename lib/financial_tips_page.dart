import 'package:flutter/material.dart';

class FinancialTipsPage extends StatelessWidget {
  const FinancialTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Tips',
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Create a Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Track your income and expenses to manage your finances effectively. Allocate funds for essential needs and prioritize savings.'),
            SizedBox(height: 20),
            Text(
              'Use Student Discounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Take advantage of discounts available to students for various services like software, transportation, and entertainment.'),
            SizedBox(height: 20),
            Text(
              'Limit Eating Out',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Cooking meals at home can save you a significant amount compared to eating out. Plan your meals and groceries wisely.'),
            SizedBox(height: 20),
            Text(
              'Manage Credit Wisely',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('If you have a credit card, use it responsibly. Pay off your balance in full each month to avoid interest charges and build good credit.'),
            SizedBox(height: 20),
            Text( 
              'Save for Emergencies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Start building an emergency fund to cover unexpected expenses like medical bills or car repairs. Aim to save at least three months of living expenses.'),
          ],
        ),
      ),
    );
  }
}
