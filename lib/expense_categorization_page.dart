import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';

class ExpenseCategorizationPage extends StatefulWidget {
  const ExpenseCategorizationPage({super.key});

  @override
  _ExpenseCategorizationPageState createState() => _ExpenseCategorizationPageState();
}

class _ExpenseCategorizationPageState extends State<ExpenseCategorizationPage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addExpense() {
    if (_categoryController.text.isEmpty || _amountController.text.isEmpty) return;

    final expense = Expense(
      _categoryController.text,
      double.parse(_amountController.text),
      DateTime.now(),
    );

    Provider.of<DataModel>(context, listen: false).addExpense(expense);

    _categoryController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Categorization',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF274C77),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addExpense,
            style: ElevatedButton.styleFrom(
             backgroundColor: const Color(0xFFA3CEF1),
             foregroundColor: const Color(0xFF274C77),
            ),
            child: const Text('Add Expense'),
          ),
          Expanded(
            child: Consumer<DataModel>(
              builder: (context, dataModel, child) {
                return ListView.builder(
                  itemCount: dataModel.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = dataModel.expenses[index];
                    return ListTile(
                      title: Text(expense.category),
                      subtitle: Text('¥${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal()}'.split(' ')[0]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: const Color(0xFF274C77),
                        onPressed: () {
                          Provider.of<DataModel>(context, listen: false).removeExpense(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
