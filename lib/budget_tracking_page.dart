import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';

class BudgetTrackingPage extends StatelessWidget {
  final TextEditingController _budgetController = TextEditingController();

  BudgetTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracking',
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _budgetController,
              decoration: const InputDecoration(
                labelText: 'Total Budget',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final budget = double.tryParse(_budgetController.text) ?? 0;
                Provider.of<DataModel>(context, listen: false).updateBudget(budget);
              },
              child: const Text('Set Budget'),
            ),
            const SizedBox(height: 20),
            Consumer<DataModel>(
              builder: (context, dataModel, child) {
                return Column(
                  children: [
                    Text('Total Budget: ¥${dataModel.totalBudget}'),
                    Text('Total Expenses: ¥${dataModel.totalExpenses}'),
                    Text('Remaining Budget: ¥${dataModel.totalBudget - dataModel.totalExpenses}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
