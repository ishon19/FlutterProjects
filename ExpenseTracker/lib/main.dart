import 'package:ExpenseTracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactions = [
      Transaction(
          id: 't1', amount: 21.22, date: DateTime.now(), title: 'Sugar'),
      Transaction(id: 't2', amount: 61.42, date: DateTime.now(), title: 'Tea'),
      Transaction(
          id: 't3', amount: 23.05, date: DateTime.now(), title: 'Masala'),
      Transaction(id: 't4', amount: 28.23, date: DateTime.now(), title: 'Salt'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Column(children: <Widget>[
        Container(
          child: Card(
              child: Text('Chart Here'),
              elevation: 10), //Widgets take the size of their child per se
          width: double.infinity,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: transactions.map((item) {
            return Card(
                elevation: 5,
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      '\$${item.amount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.purple,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(DateFormat().format(item.date),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  )
                ]));
          }).toList(),
        )
      ]),
    );
  }
}
