# SmartSavings

A simple personal finance app built with Flutter. It puts everyday money tasks in one place: a monthly budget, expenses by category, savings goals, bill reminders and debts.

Built in July 2024 by two students of the same department at Kyoto University of Advanced Science, as an early project to learn Flutter and app state management.

## Features

| Screen | What it does |
|---|---|
| Budget Tracking | Set a total budget and compare it with total expenses (in yen) |
| Expense Categorization | Add expenses with a category and amount |
| Savings Goals | Add a goal with an amount, start date and end date |
| Bill Reminders | Keep a list of bills with amounts and due dates |
| Debt Management | Keep a list of debts by creditor, amount and due date |
| Financial Tips | Short tips for managing money |

All data is saved on the device with `shared_preferences`, so it stays after the app is closed. No account or server is needed.

## How it's built

- **Flutter / Dart**: one codebase for Android and the web
- **Provider** (`ChangeNotifier`): a single `DataModel` holds the app state and notifies the screens when data changes
- **shared_preferences**: each list is stored as JSON (`toJson` / `fromJson` on every model class)

```
lib/
  main.dart                         home screen with a grid of features
  data_model.dart                   models (Expense, SavingGoal, BillReminder, Debt) + state + storage
  budget_tracking_page.dart
  expense_categorization_page.dart
  savings_goals_page.dart
  bill_reminders_page.dart
  debt_management_page.dart
  financial_tips_page.dart
```

## Run it

With the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed:

```bash
flutter pub get
flutter run            # pick an Android device/emulator or Chrome
```

## What we would improve today

- Progress bars for savings goals, and totals for debts
- Notifications for bill due dates (they are only listed now)
- Charts of spending by category
- Tests for the data model
