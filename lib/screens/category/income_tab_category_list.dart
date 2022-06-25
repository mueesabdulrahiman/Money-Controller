import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/categories/category_model.dart';

class IncomeCategoryScreen extends StatelessWidget {
  const IncomeCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB.instance.incomeCategoryNotifier, 
      builder: (BuildContext context, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(
      itemCount: newList.length,
      itemBuilder: (ctx, index) {
        return Card(
          child: ListTile(
            title: Text(newList[index].name),
            trailing:  TextButton(child: const Icon(Icons.delete), onPressed: (){
              CategoryDB.instance.deleteCategory(newList[index]);
            },),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
    );
    }
    );
  }
}
