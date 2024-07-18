import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';

class SavingsGoalsPage extends StatefulWidget {
  const SavingsGoalsPage({super.key});

  @override
  _SavingsGoalsPageState createState() => _SavingsGoalsPageState();
}

class _SavingsGoalsPageState extends State<SavingsGoalsPage> {
  final TextEditingController _goalNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Goals',
        style: TextStyle(color: Colors.white)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalNameController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Start Date: ${_startDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
              ],
            ),
            Row(
              children: [
                Text('End Date: ${_endDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final goalName = _goalNameController.text;
                final amount = double.tryParse(_amountController.text) ?? 0;
                if (goalName.isNotEmpty && amount > 0) {
                  Provider.of<DataModel>(context, listen: false)
                      .addGoal(SavingGoal(goalName, amount, _startDate, _endDate));
                }
              },
              child: const Text('Add Goal'),
            ),
            const SizedBox(height: 20),
            Consumer<DataModel>(
              builder: (context, dataModel, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: dataModel.goals.length,
                    itemBuilder: (context, index) {
                      final goal = dataModel.goals[index];
                      return ListTile(
                        title: Text(goal.goalName),
                        subtitle: Text('Amount: ¥${goal.amount}\nStart Date: ${goal.startDate.toLocal()}\nEnd Date: ${goal.endDate.toLocal()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            dataModel.removeGoal(index);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
