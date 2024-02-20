import 'package:hive/hive.dart';
import '../expense/expense_items.dart';

class HiveDataBase {
  final _hiveBox = Hive.box('expense_database');

  void saveData(List<ExpenseItems> allItems) {
    List<List<dynamic>> allItemsFormatted = [];
    for (var expense in allItems) {
      List<dynamic> itemsFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allItemsFormatted.add(itemsFormatted);
    }
    _hiveBox.put('All_Expenses', allItemsFormatted);
  }

  List<ExpenseItems> readData() {
    List savedExpenses = _hiveBox.get('All_Expenses') ?? [];
    List<ExpenseItems> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItems expense = ExpenseItems(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
