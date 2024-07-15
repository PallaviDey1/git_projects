import 'package:flutter/material.dart';
import 'package:flutter_classes/widgets/expenses.dart';
import 'package:flutter_classes/models/expense.dart';
import 'package:flutter_classes/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget{

  const ExpensesList({super.key,required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;
    



  @override
    Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx,index ) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          
          margin: Theme.of(context).cardTheme.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
         child: ExpenseItem(expenses[index]),
         
         ),
      
    );

      
  
  }
}