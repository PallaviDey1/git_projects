import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_classes/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  DateTime?  _selectedDate;
  Category _selectedCategory=Category.food;




  void _presentDatePicker() async {
    final now=DateTime.now();
    final initialDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate=await showDatePicker(
      context: context, 
      firstDate: initialDate,
       lastDate: now,
       );
       setState(() {
         _selectedDate=pickedDate;
       });
  }
  void _submitExpenseData(){
    final enteredAmount=double.tryParse(amountController.text);
    final amountIsInvalid=enteredAmount==null || enteredAmount<=0;
    if(titleController.text.trim().isEmpty || 
    amountIsInvalid ||
    _selectedDate==null) {
      Platform.isIOS?
      showDialog(
        context: context,
        builder: (ctx){
      
          return CupertinoAlertDialog(
            title: const Text("Invalid Input"),
            content: const Text("Please enter a valid title and amount"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const Text("Okay"),
              )
            ],

          );

        }
        ):showDialog(
        context: context,
        builder: (ctx){
      
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text("Please enter a valid title and amount"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const Text("Okay"),
              )
            ],

          );

        }
        );
        return;
    }
    widget.onAddExpense(Expense(title: titleController.text, 
    amount: enteredAmount,
     date: _selectedDate!, category: _selectedCategory,
     ),
     );
     Navigator.pop(context);
  }
 

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  
   Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      print(constraints.minWidth);
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.maxHeight);
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (constraints.maxWidth > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (constraints.maxWidth > 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Selected Date"
                                  : formatter.format(
                                      _selectedDate!,
                                    ),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Selected Date"
                                  : formatter.format(
                                      _selectedDate!,
                                    ),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (constraints.maxWidth > 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}


              
               