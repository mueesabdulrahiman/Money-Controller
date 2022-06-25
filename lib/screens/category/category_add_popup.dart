import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/categories/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
final _categoryName = TextEditingController();
Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _categoryName,
                decoration: const InputDecoration(
                  hintText: 'Enter category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  RadioButton(title: 'income', type: CategoryType.income),
                  RadioButton(title: 'expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _category = CategoryModel(
                        name: _categoryName.text,
                        type: selectedCategoryNotifier.value,
                        id: DateTime.now().microsecondsSinceEpoch.toString());
                    CategoryDB.instance.insertCategory(_category);
                    Navigator.pop(ctx);
                    _categoryName.clear();
                    
                  },
                  child: const Text('Add')),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategoryNotifier,
      builder: (BuildContext context, CategoryType newCategory, Widget? _) {
        return Row(
          children: [
            Radio(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value as CategoryType;
                selectedCategoryNotifier.notifyListeners();
              },
            ),
            Text(title),
          ],
        );
      },
    );
  }
}
