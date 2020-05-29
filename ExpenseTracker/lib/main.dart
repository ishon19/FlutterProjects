import 'package:ExpenseTracker/models/transaction.dart';
import 'package:ExpenseTracker/widgets/newTransactions.dart';
import 'package:ExpenseTracker/widgets/transactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.pink,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.deepPurple,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   amount: 21.22,
    //   date: DateTime.now(),
    //   title: 'Sugar',
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 61.42,
    //   date: DateTime.now(),
    //   title: 'Tea',
    // ),
    // Transaction(
    //   id: 't3',
    //   amount: 23.05,
    //   date: DateTime.now(),
    //   title: 'Masala',
    // ),
    // Transaction(
    //   id: 't4',
    //   amount: 28.23,
    //   date: DateTime.now(),
    //   title: 'Salt',
    // ),
  ];

  void _addNewTransaction(String item, double currentAmount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: item,
      amount: currentAmount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (_) {
          return NewTransactions(_addNewTransaction);
        });
    // showCupertinoModalPopup(context: buildContext, builder: (_){
    //    return NewTransactions(_addNewTransaction);
    //  });
    // showDialog(context: buildContext, builder: (context) {return NewTransactions(_addNewTransaction);},);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            child: Card(
                child: Text('Chart Here'),
                elevation: 10), //Widgets take the size of their child per se
            width: double.infinity,
          ),
          TransactionList(_transactions),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
