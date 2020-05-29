import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransactions(this.addTransactionHandler);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmitHandler() {
    print('Item entered is ${titleController.text} and amount is ${amountController.text}');

    var enteredTitle = titleController.text;
    var enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount<=0){
      return;
    }

    widget.addTransactionHandler(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            onSubmitted: (_) => onSubmitHandler(),
            decoration: InputDecoration(
              labelText: 'Enter Item',
            ),
            controller: titleController,
            //onChanged: (val) {print('Item entered $val'); titleInput = val;},
          ),
          TextField(
            onSubmitted: (_) => onSubmitHandler(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Amount',
            ),
            controller: amountController,
            //onChanged: (val) { print('amount entered $val'); amountInput = val;},
          ),
          FlatButton(
            onPressed: onSubmitHandler,
            child: Text('Add Transaction'),
            textColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
