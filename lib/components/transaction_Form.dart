import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleControler = TextEditingController();
  final valueControler = TextEditingController();
  DateTime date = DateTime.now();

  _submitForm() {
    if (titleControler.text.isEmpty || valueControler.text.isEmpty) {
      return;
    }

    widget.onSubmit(
        titleControler.text, double.tryParse(valueControler.text) ?? 0.0, date);
  }

  _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        date = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleControler,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: valueControler,
              decoration: InputDecoration(labelText: 'Valor em R\$'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(DateFormat('dd/MM/y').format(date)),
                  ),
                ),
                Container(
                  child: TextButton(
                    child: Text('Adicionar Data'),
                    onPressed: _showDataPicker,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    'Adicionar Transação',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
