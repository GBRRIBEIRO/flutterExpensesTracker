import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //Get refers to a getter that is a function that the only reason to exist is to return something
  //This getter returns a list generated by the List method 'generate' which generates a list with limited length
  //The generated list is a list of maps that contains a string and an object

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      //weekDay will contain the last 7 days of the week counting from now ('DateTime.now()')
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      //totalSum is a variable that will contain the total expenses of a day
      double totalSum = 0.0;

      //This for loop loops through the recentTransactions list to find the exact same day that is inside of 'weekDay',
      //take the expenses of that day and put it on the 'totalSum'

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].value;
        }
      }
      //Returns the Map<String,Object>>
      return {
        //substring syntax = ('start letter', 'finishing letter')
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    //Fold changes a list to another type
    //Calculates the total spending of the week
    //The syntax is, ('inicial value', ('total','item of the list'))

    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ...groupedTransactionsValues.map((tx) {
                return Flexible(
                  //Make the child use the avaliable space
                  fit: FlexFit.tight,
                  child: ChartBar(
                      tx['day'].toString(),
                      (tx['amount'] as double),
                      totalSpending == 0.0
                          ? 0.0
                          : (tx['amount'] as double) / totalSpending),
                );
              })
            ]),
      ),
    );
  }
}