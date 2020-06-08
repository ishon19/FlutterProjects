import 'package:ExpenseTracker/models/transaction.dart';
import 'package:ExpenseTracker/widgets/chart.dart';
import 'package:ExpenseTracker/widgets/newTransactions.dart';
import 'package:ExpenseTracker/widgets/transactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  //get the list of transactions that happened in the last week only
  List<Transaction> get _recentTransaction {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String item, double currentAmount, DateTime selectedDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: '${item[0].toUpperCase()}${item.substring(
        1,
      )}',
      amount: currentAmount,
      date: selectedDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
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
    final appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart'),
              Switch(
                value: _showChart,
                onChanged: (value) {
                   setState(() {
                     _showChart = value;
                   });
                },
              ),
            ],
          ),
          _showChart?Container(
            child: Chart(_recentTransaction),
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
          ):Container(),
          Container(
            child: TransactionList(_transactions, _deleteTransaction),
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
          ),
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
