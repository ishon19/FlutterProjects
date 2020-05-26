import 'package:ExpenseTracker/models/transaction.dart';
import 'package:ExpenseTracker/widgets/newTransactions.dart';
import 'package:ExpenseTracker/widgets/transactionList.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      amount: 21.22,
      date: DateTime.now(),
      title: 'Sugar',
    ),
    Transaction(
      id: 't2',
      amount: 61.42,
      date: DateTime.now(),
      title: 'Tea',
    ),
    Transaction(
      id: 't3',
      amount: 23.05,
      date: DateTime.now(),
      title: 'Masala',
    ),
    Transaction(
      id: 't4',
      amount: 28.23,
      date: DateTime.now(),
      title: 'Salt',
    ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransactions(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
