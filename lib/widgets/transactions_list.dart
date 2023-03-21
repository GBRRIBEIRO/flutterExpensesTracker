import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: _userTransactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      child: Row(
                    children: [
                      Container(
                        child: Text(
                          "R\$: ${_userTransactions[index].value.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                      ),
                      Column(
                        children: [
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd('pt_BR')
                                .format(_userTransactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    ],
                  ));
                },
                itemCount: _userTransactions.length,
              ));
  }
}
