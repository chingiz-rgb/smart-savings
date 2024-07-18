import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_model.dart';

class BillRemindersPage extends StatelessWidget {
  const BillRemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController billNameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    DateTime dueDate = DateTime.now();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != dueDate) {
        dueDate = picked;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Reminders',
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: billNameController,
              decoration: const InputDecoration(
                labelText: 'Bill Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Due Date: ${dueDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final billName = billNameController.text;
                final amount = double.tryParse(amountController.text) ?? 0;
                if (billName.isNotEmpty && amount > 0) {
                  Provider.of<DataModel>(context, listen: false)
                      .addBill(BillReminder(billName, amount, dueDate));
                }
              },
              child: const Text('Add Bill Reminder'),
            ),
            const SizedBox(height: 20),
            Consumer<DataModel>(
              builder: (context, dataModel, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: dataModel.bills.length,
                    itemBuilder: (context, index) {
                      final bill = dataModel.bills[index];
                      return ListTile(
                        title: Text(bill.billName),
                        subtitle: Text('Amount: ¥${bill.amount}\nDue Date: ${bill.dueDate.toLocal()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            dataModel.removeBill(index);
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
