import 'dart:math';

import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_Form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/models/transactions.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Expenses(),
    );
  }
}

class Expenses extends StatefulWidget {
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Transactions> _transactions = [
    /*Transactions(
      id: 't1',
      title: 'LUZ',
      value: 200.00,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      title: 'Agua',
      value: 50.00,
      date: DateTime.now(),
    ),*/
  ];

  _addTransaction(String title, double value, DateTime date) {
    setState(() {
      _transactions.add(Transactions(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date,
      ));
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String value) {
    setState(() {
      _transactions.removeWhere((element) => element.id == value);
    });
    print(value);
  }

  List<Transactions> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  double get _totalValue {
    return _recentTransactions.fold(0.0, (sum, tr) {
      return sum += tr.value;
    });
  }

  _showModal(BuildContext modal) {
    showModalBottomSheet(
        context: modal,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Depesas Pessoais'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chart(_recentTransactions, _totalValue),
            Container(
              height: 300,
              child: TransactionList(_transactions, _removeTransaction),
            ),
            FloatingActionButton(
              onPressed: () => _showModal(context),
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
