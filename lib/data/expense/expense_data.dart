import 'package:expense_tracker_app/data/data%20time/data_time_helper.dart';
import 'package:expense_tracker_app/data/data%20time/hive_database.dart';
import 'package:flutter/foundation.dart';
import 'expense_items.dart';

class ExpenseData with ChangeNotifier {
  List<ExpenseItems> overallExpenseList = [];

  List<ExpenseItems> getAllExpenseItems() {
    return overallExpenseList;
  }

  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  void addNewExpense(ExpenseItems newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(ExpenseItems expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayNames(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thur';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();
    DateTime? startOfWeek;
    for (int i = 0; i < 7; i++) {
      if (getDayNames(today.subtract(Duration(days: i))) == 'sun') {
        startOfWeek = today.subtract(Duration(days: i));
        break;
      }
    }
    return startOfWeek ?? DateTime.now();
  }

  String getDayName(DateTime date) {
    return '';
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDayTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
