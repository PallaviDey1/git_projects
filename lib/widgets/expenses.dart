import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_classes/widgets/chart/chart.dart';
import 'package:flutter_classes/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_classes/models/expense.dart';
import 'package:flutter_classes/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses=[
    Expense(
      title: 'Flutter Course', 
      amount: 10.50, 
      date: DateTime.now(), 
      category:Category.work ),
    Expense(
      title: 'Cinema', 
      amount: 21.00, 
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.leisure)

  ];
  void addNewExpense(Expense exp){
    setState(() {
      _registeredExpenses.add(exp);
    });
  }

  void onRemoveExpense(Expense exp){
    final expenseIndex=_registeredExpenses.indexOf(exp);
    setState(() {
      _registeredExpenses.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "undo",
           onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, exp);
            });
           }),
    ),
    );
  }


void _addExpenseOverlay(){
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
     builder: (contx){
    return NewExpense(onAddExpense: addNewExpense);
  });

}

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    

    Widget mainContent=const Center(child: Text("No expenses yet,click on + to add"),
    );
    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
        expenses:_registeredExpenses, 
        onRemoveExpense: onRemoveExpense,
        );
    }
    
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay, 
            icon: Icon(Icons.add),
            ),
        ],
      ),
      body:width< 600
      ?Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent
            )
        ],
        )
        :Row(children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent),
          
        ],
        ),
        );
  }
}