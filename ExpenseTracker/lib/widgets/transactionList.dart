import 'package:ExpenseTracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: _transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'Its so empty here!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (ctx, idx) {
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
                            '\$${_transactions[idx].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _transactions[idx].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(DateFormat().format(_transactions[idx].date),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        )
                      ]));
                },
              ));
  }
}
