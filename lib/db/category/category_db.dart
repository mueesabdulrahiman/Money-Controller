import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/categories/category_model.dart';

const CATEGORY_DB_NAME = 'category_db';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategories();

  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(CategoryModel value);
}

class CategoryDB implements CategoryDBFunctions {

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryNotifier = ValueNotifier([]);


  

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDb.put(value.id, value);
     refreshUI();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryNotifier.value.clear();
    expenseCategoryNotifier.value.clear();
    await Future.forEach(_allCategories, (CategoryModel categoryModel) {
      if (categoryModel.type == CategoryType.income) {
        incomeCategoryNotifier.value.add(categoryModel);
      } else {
        expenseCategoryNotifier.value.add(categoryModel);
      }
    });
    incomeCategoryNotifier.notifyListeners();
    expenseCategoryNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(value.id);
    refreshUI();
  }
}
