import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredValue = double.parse(valueController.text);

    if (enteredTitle.isEmpty || enteredValue <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredValue);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Value'),
            controller: valueController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: submitData,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
