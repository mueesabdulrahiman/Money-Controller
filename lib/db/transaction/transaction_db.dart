import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';

const CATEGORY_DB_NAME = 'transaction_db';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDBFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

   ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  Future<void> insertTransaction(TransactionModel value) async {
    final _db = await Hive.openBox<TransactionModel>(CATEGORY_DB_NAME);
    _db.put(value.id, value);
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(CATEGORY_DB_NAME);
    return _db.values.toList();
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(CATEGORY_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
