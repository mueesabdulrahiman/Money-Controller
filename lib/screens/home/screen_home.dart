import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/category_add_popup.dart';
import 'package:money_management_app/screens/category/screen_category.dart';
import 'package:money_management_app/screens/home/widgets/navigation_bar.dart';
import 'package:money_management_app/screens/transactions/add_transaction/screen_add_transaction.dart';
import 'package:money_management_app/screens/transactions/screen_transactions.dart';

class HomeScreen extends StatelessWidget {
 const  HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
     TransactionScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      
      bottomNavigationBar: const HomeScreenNavigationBar(),
      body: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.pushNamed(context, ScreenAddTransaction.route);
            
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
