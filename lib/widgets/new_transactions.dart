import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if(amountController == null){
      return;
    }
    if(_selectedDate == null){
      return;
    }
    final enteredTitleData = titleController.text;
    final enteredAmountData = double.parse(amountController.text);

    if (enteredTitleData.isEmpty && enteredAmountData <= 0 && _selectedDate == null) {
      return;
    }
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickeDate) {
      if (pickeDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickeDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title :"),
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount :"),
              // onChanged: (val) => amountInput = val,
              controller: amountController,
              // keyboardType: TextInputType.numberWithOptions(decimal: true),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No Date Chose!"
                          : "Picked Date : ${DateFormat.yMd().format(_selectedDate)} ",
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Chose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
