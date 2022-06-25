import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/models/categories/category_model.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';
import 'package:money_management_app/screens/transactions/widgets/main_container.dart';
import 'package:money_management_app/screens/transactions/widgets/main_listview.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   CategoryDB.instance.refreshUI();
  //   TransactionDB.instance.refresh();
  //   return SafeArea(
  //     child: ValueListenableBuilder(
  //       valueListenable: TransactionDB.instance.transactionListNotifier,
  //       builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
  //         return ListView.separated(
  //           padding: const EdgeInsets.all(8.0),
  //           itemBuilder: (context, index) {
  //             return Slidable(
  //               startActionPane: ActionPane(
  //                 motion: const StretchMotion(),
  //                 children: [
  //                   SlidableAction(
  //                     onPressed: (ctx) {
  //                       TransactionDB.instance
  //                           .deleteTransaction(newList[index].id!);
  //                     },
  //                     icon: Icons.delete,
  //                     label: 'Delete',
  //                   ),
  //                 ],
  //               ),
  //               child: Card(
  //                 elevation: 2.0,
  //                 child: ListTile(
  //                   leading: CircleAvatar(
  //                     radius: 50.0,
  //                     child: Text(
  //                       parsedDate(newList[index].date),
  //                       textAlign: TextAlign.center,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     backgroundColor:
  //                         newList[index].type == CategoryType.income
  //                             ? Colors.green
  //                             : Colors.red,
  //                   ),
  //                   title: Text(newList[index].amount.toString()),
  //                   subtitle: Text(newList[index].purpose),
  //                 ),
  //               ),
  //             );
  //           },
  //           separatorBuilder: (context, value) => const SizedBox(
  //             height: 10.0,
  //           ),
  //           itemCount: newList.length,
  //         );
  //       },
  //     ),
  //   );
  //}

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();

    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            MainContainer(
              screenSize: screenSize,
              totalBalance: 1000,
              tottalIncome: 1500,
              totalExpense: 500,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext ctx, List<TransactionModel> newList,
                  Widget? _) {
                return Expanded(
                  child: ListView.separated(itemBuilder: (ctx, index){
                    return MainListView(
                    date: newList[index].date,
                    amount: newList[index].amount,
                    note: newList[index].purpose,
                    type: newList[index].type,
                  );
                  }, separatorBuilder: (ctx, index) => const SizedBox(
                          height: 10.0,
                        ),
                    itemCount: newList.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
