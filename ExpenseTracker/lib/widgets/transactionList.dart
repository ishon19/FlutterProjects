import 'package:ExpenseTracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

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
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text('\$${_transactions[idx].amount}')),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        _transactions[idx].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_transactions[idx].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()=>_deleteTransaction(_transactions[idx].id),
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  );
                },
              ));
  }
}
