import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/expense_tab_category_list.dart';
import 'package:money_management_app/screens/category/income_tab_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: const [
              Tab(
                height: 25.0,
                text: 'Income',
              ),
              Tab(
                height: 25.0,
                text: 'Expense',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  const [
                IncomeCategoryScreen(),
                ExpenseCategoryScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
