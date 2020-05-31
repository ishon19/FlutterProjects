import 'package:ExpenseTracker/models/transaction.dart';
import 'package:ExpenseTracker/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final dayOfWeek = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (dayOfWeek.day == recentTransactions[i].date.day &&
            dayOfWeek.month == recentTransactions[i].date.month &&
            dayOfWeek.year == recentTransactions[i].date.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(dayOfWeek).toUpperCase().substring(0, 3),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
      0.0,
      (previousValue, element) => previousValue + element['amount'],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['amount'],
              (totalSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / totalSpending),
            ),
          );
        }).toList(),
      ),
    );
  }
}
