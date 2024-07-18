import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Expense {
  final String category;
  final double amount;
  final DateTime date;

  Expense(this.category, this.amount, this.date);

  Map<String, dynamic> toJson() => {
    'category': category,
    'amount': amount,
    'date': date.toIso8601String(),
  };

  static Expense fromJson(Map<String, dynamic> json) => Expense(
    json['category'],
    json['amount'],
    DateTime.parse(json['date']),
  );
}

class SavingGoal {
  final String goalName;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;

  SavingGoal(this.goalName, this.amount, this.startDate, this.endDate);

  Map<String, dynamic> toJson() => {
    'goalName': goalName,
    'amount': amount,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  };

  static SavingGoal fromJson(Map<String, dynamic> json) => SavingGoal(
    json['goalName'],
    json['amount'],
    DateTime.parse(json['startDate']),
    DateTime.parse(json['endDate']),
  );
}

class BillReminder {
  final String billName;
  final double amount;
  final DateTime dueDate;

  BillReminder(this.billName, this.amount, this.dueDate);

  Map<String, dynamic> toJson() => {
    'billName': billName,
    'amount': amount,
    'dueDate': dueDate.toIso8601String(),
  };

  static BillReminder fromJson(Map<String, dynamic> json) => BillReminder(
    json['billName'],
    json['amount'],
    DateTime.parse(json['dueDate']),
  );
}

class Debt {
  final String creditor;
  final double amount;
  final DateTime dueDate;

  Debt(this.creditor, this.amount, this.dueDate);

  Map<String, dynamic> toJson() => {
    'creditor': creditor,
    'amount': amount,
    'dueDate': dueDate.toIso8601String(),
  };

  static Debt fromJson(Map<String, dynamic> json) => Debt(
    json['creditor'],
    json['amount'],
    DateTime.parse(json['dueDate']),
  );
}

class DataModel extends ChangeNotifier {
  List<Expense> expenses = [];
  List<SavingGoal> goals = [];
  List<BillReminder> bills = [];
  List<Debt> debts = [];
  double totalBudget = 0;

  DataModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    expenses = (jsonDecode(prefs.getString('expenses') ?? '[]') as List)
        .map((e) => Expense.fromJson(e))
        .toList();
    goals = (jsonDecode(prefs.getString('goals') ?? '[]') as List)
        .map((e) => SavingGoal.fromJson(e))
        .toList();
    bills = (jsonDecode(prefs.getString('bills') ?? '[]') as List)
        .map((e) => BillReminder.fromJson(e))
        .toList();
    debts = (jsonDecode(prefs.getString('debts') ?? '[]') as List)
        .map((e) => Debt.fromJson(e))
        .toList();
    totalBudget = prefs.getDouble('totalBudget') ?? 0;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('expenses', jsonEncode(expenses));
    prefs.setString('goals', jsonEncode(goals));
    prefs.setString('bills', jsonEncode(bills));
    prefs.setString('debts', jsonEncode(debts));
    prefs.setDouble('totalBudget', totalBudget);
  }

  void addExpense(Expense expense) {
    expenses.add(expense);
    _saveData();
    notifyListeners();
  }

  void removeExpense(int index) {
    expenses.removeAt(index);
    _saveData();
    notifyListeners();
  }

  void addGoal(SavingGoal goal) {
    goals.add(goal);
    _saveData();
    notifyListeners();
  }

  void removeGoal(int index) {
    goals.removeAt(index);
    _saveData();
    notifyListeners();
  }

  void addBill(BillReminder bill) {
    bills.add(bill);
    _saveData();
    notifyListeners();
  }

  void removeBill(int index) {
    bills.removeAt(index);
    _saveData();
    notifyListeners();
  }

  void addDebt(Debt debt) {
    debts.add(debt);
    _saveData();
    notifyListeners();
  }

  void removeDebt(int index) {
    debts.removeAt(index);
    _saveData();
    notifyListeners();
  }

  void updateBudget(double budget) {
    totalBudget = budget;
    _saveData();
    notifyListeners();
  }

  double get totalExpenses {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
}
