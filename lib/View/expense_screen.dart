import 'package:expense_tracker_app/data/expense/expense_summary.dart';
import 'package:expense_tracker_app/utils/components/data_tile.dart';
import 'package:expense_tracker_app/utils/routes/route_name.dart';
import 'package:expense_tracker_app/utils/utils.dart';
import 'package:expense_tracker_app/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/expense/expense_data.dart';
import '../data/expense/expense_items.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode amountNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void alertDialogueBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add new expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                focusNode: nameNode,
                cursorColor: Colors.teal.shade500,
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade500),
                  ),
                ),
                onSubmitted: (value) {
                  Utils.fieldFocusChange(context, nameNode, amountNode);
                },
              ),
              TextField(
                focusNode: amountNode,
                cursorColor: Colors.teal.shade500,
                controller: amountController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade500),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: save,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.teal.shade500),
              ),
            ),
            TextButton(
              onPressed: cancel,
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.teal.shade500),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteExpense(ExpenseItems expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    ExpenseItems newExpense = ExpenseItems(
      name: nameController.text.toString(),
      amount: amountController.text.toString(),
      dateTime: DateTime.now(),
    );
    if (amountController.text.length > 0) {
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    } else {
      Utils.flushBarMessage('Please enter new amount', context);
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    nameController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        automaticallyImplyLeading: false,
        title: Text(
          'Expense Tracker',
          style: TextStyle(
            fontFamily: GoogleFonts.aleo().fontFamily,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Padding(
                child: InkWell(
                  onTap: () {
                    value.removeUser().then((value) {
                      Navigator.pushNamed(context, RouteName.login);
                    });
                  },
                  child: Icon(Icons.login_outlined, color: Colors.white),
                ),
                padding: EdgeInsets.only(right: 15),
              );
            },
          ),
        ],
      ),
      body: Scaffold(
        body: Consumer<ExpenseData>(
          builder: (BuildContext context, value, Widget? child) {
            return ListView(
              children: [
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseItems().length,
                  itemBuilder: (context, index) {
                    return DataTile(
                      name: value.overallExpenseList[index].name,
                      dateTime: value.overallExpenseList[index].dateTime,
                      amount: value.overallExpenseList[index].amount.toString(),
                      deleteTapped: (p0) =>
                          deleteExpense(value.getAllExpenseItems()[index]),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.teal.shade500,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          alertDialogueBox();
        },
      ),
    );
  }
}
