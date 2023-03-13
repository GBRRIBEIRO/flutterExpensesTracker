import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 1, title: 'Car', value: 10000, date: DateTime.now()),
    Transaction(id: 2, title: 'Drugs', value: 1000, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      body: Column(children: [
        Card(
          child: Container(
            child: Text('Chart'),
            width: 100,
          ),
        ),
        Column(
          children: <Widget>[
            ...transactions.map((ts) {
              return Card(
                  child: Row(
                children: [
                  Container(
                    child: Text(
                      "R\$: ${ts.value}",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    )),
                  ),
                  Column(
                    children: [
                      Text(
                        ts.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd('pt_BR').format(ts.date),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ));
            }).toList()
          ],
        )
      ]),
    );
  }
}
