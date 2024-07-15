import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();

const uuid=Uuid();


enum Category{
  food,leisure,work,travel
}

const categoryIcons={
  Category.food:Icons.dining,
  Category.travel:Icons.flight,
  Category.leisure:Icons.movie_creation_rounded,
  Category.work:Icons.work,
};




class Expense{

  Expense({required this.title,
  required this.amount,
  required this.date,
  required this.category
  }):id=uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate{
       return formatter.format(date);
  }
}

class ExpenseBucket{


  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category,required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category) 
  : expenses=allExpenses
          .where((expense) => (expense.category==category))
          .toList();

  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }



    return sum;
  }


}