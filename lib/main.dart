import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1',
      title: 'Car',
      value: 10000,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Drugs',
      value: 1000,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String titleTx, double valueTx) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        value: valueTx,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void openNewTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              openNewTransaction(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            child: Container(
              child: Text('Chart'),
              width: 100,
            ),
          ),
          TransactionList(_userTransactions),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
