import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DataTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  DataTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: deleteTapped,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
            'Date:' + '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
        trailing: Text(
          '\$' + amount,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
