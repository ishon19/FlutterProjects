import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransactions(this.addTransactionHandler){
    print('Constructor of new transaction widget called!');
  }

  @override
  _NewTransactionsState createState(){
     print("createState of newTransaction called");
    return _NewTransactionsState();
  }
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionsState() {
    print('constructor of _NewTransactionsState called');
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState() called');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransactions oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget() called');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose() called');
  }

  void onSubmitHandler() {
    print(
      'Item entered is ${_titleController.text} and amount is ${_amountController.text}',
    );

    var enteredTitle = _titleController.text;
    var enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransactionHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onSubmitted: (_) => onSubmitHandler(),
                decoration: InputDecoration(
                  labelText: 'Enter Item',
                ),
                controller: _titleController,
                //onChanged: (val) {print('Item entered $val'); titleInput = val;},
              ),
              TextField(
                onSubmitted: (_) => onSubmitHandler(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                ),
                controller: _amountController,
                //onChanged: (val) { print('amount entered $val'); amountInput = val;},
              ),
              //Adding the date picker here
              Container(
                height: 70,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date chosen!'
                            : 'Selected Date is : ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _displayDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: onSubmitHandler,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
