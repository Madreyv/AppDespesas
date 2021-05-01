import 'package:despesas/components/chart_bar.dart';
import 'package:despesas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> _recentTransactions;
  final double _totalValue;

  Chart(this._recentTransactions, this._totalValue);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (int i = 0; i < _recentTransactions.length; i++) {
        bool sameDay = _recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = _recentTransactions[i].date.month == weekDay.month;
        bool sameYear = _recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameYear && sameMonth) {
          totalSum += _recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: groupedTransactions.map((e) {
            return Expanded(
              child: ChartBar(
                  weekDay: e['day'],
                  value: e['value'],
                  percentage: _totalValue != 0.0
                      ? (e['value'] as double) / _totalValue
                      : 0.00),
            );
          }).toList(),
        ),
      ),
    );
  }
}
