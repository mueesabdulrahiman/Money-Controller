import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/models/categories/category_model.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';


extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}


class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({Key? key}) : super(key: key);
  static const route = 'Add_Transaction_Screen';

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _purposeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Enter Purpose',
                ),
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                ),
              ),
              TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());
                    if (_selectedDateTemp == null) {
                      return;
                    } else {
                      print(_selectedDateTemp);
                      setState(() {
                        _selectedDate = _selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Calender'
                      : _selectedDate.toString())),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = newValue as CategoryType;
                              _categoryID = null;
                            });
                          }),
                      const Text('income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = newValue as CategoryType;
                              _categoryID = null;
                            });
                          }),
                      const Text('expense'),
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                  hint: const Text('selected Category'),
                  value: _categoryID,
                  items: (_selectedCategoryType == CategoryType.income
                          ? CategoryDB.instance.incomeCategoryNotifier.value
                          : CategoryDB.instance.expenseCategoryNotifier.value)
                      .map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name),
                      value: e.id,
                      onTap: (){
                        _selectedCategoryModel = e;
                        print(e.toString());
                      },
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _categoryID = newValue;
                    });
                  }),
              ElevatedButton(
                  onPressed: (() {
                    addTransaction();

                  }),
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    
    final _purposeText = _purposeController.text.toCapitalized();
    final _amountText = _amountController.text.toCapitalized();

    if(_purposeText.isEmpty || _amountText.isEmpty || _selectedDate == null || _selectedCategoryModel == null ){
      return;
    }

   final _parsedAmount = double.tryParse(_amountText);
   if(_parsedAmount == null){
     return;
   }
    final _transactionModel = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!,
        );

     await TransactionDB.instance.insertTransaction(_transactionModel);

     Navigator.pop(context);
      TransactionDB.instance.refresh();

  }
}
