import 'package:despesas/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _transactionList;
  final void Function(String) onSubmit;

  TransactionList(this._transactionList, this.onSubmit);
  @override
  Widget build(BuildContext context) {
    return _transactionList.isEmpty
        ? Column(
            children: [
              Text(
                'Não Existem Transações Cadastradas!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 200,
                child: Image(
                  image: AssetImage('assets/img/waiting.png'),
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: _transactionList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                            'R\$${_transactionList[index].value.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(_transactionList[index].title),
                  subtitle: Text(
                      '${DateFormat('dMMMy').format(_transactionList[index].date)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => onSubmit(_transactionList[index].id),
                  ),
                ),
              );
            },
          );
  }
}
