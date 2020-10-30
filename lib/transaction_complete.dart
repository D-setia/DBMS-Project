import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooad_project/main.dart';

class TransactionComplete extends StatelessWidget {
  final int _userId;
  TransactionComplete(this._userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit Card Processing"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 120.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Transaction Complete",
                style: TextStyle(fontSize: 30.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        _userId,
                        title: "CCPS Demo Home Page",
                      )));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.check,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
