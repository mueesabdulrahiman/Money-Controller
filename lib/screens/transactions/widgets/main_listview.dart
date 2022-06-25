import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/models/categories/category_model.dart';

class MainListView extends StatelessWidget {
  const MainListView(
      {Key? key, required this.date, required this.amount, required this.note, required this.type})
      : super(key: key);

  final DateTime date;
  final double amount;
  final String note;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade50,
      contentPadding: const  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: CircleAvatar(
        child: Text(
          parsedDate(date),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15.0),
        ),
        radius: 25.0,
      ),
      title: Text(note, maxLines: 2, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis ,style: TextStyle(color: Colors.grey[600]),),
      trailing:  Text((type == CategoryType.income? '+' :'-')  + '$amount', style: TextStyle(color: type == CategoryType.income ? Colors.green : Colors.red),),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splittedDate = _date.split(' ');
    return '${_splittedDate.last}\n${_splittedDate.first}';
  }
}
