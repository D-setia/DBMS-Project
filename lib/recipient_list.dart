import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ooad_project/merchant.dart';
import 'package:ooad_project/recipient.dart';
import 'package:http/http.dart' as http;
import 'package:ooad_project/database.dart';

class RecipientList extends StatefulWidget {
  final double _balance;
  final int _userId;
  const RecipientList(this._balance, this._userId, {Key key}) : super(key: key);

  @override
  _RecipientListState createState() => _RecipientListState();
}

class _RecipientListState extends State<RecipientList> {
  bool gotList = false;
  List<Merchant> _merchants = [];
  List<Widget> _merchantWidgets = [];

  @override
  void initState() {
    super.initState();
    displayUsers();
  }

  void displayUsers() async {
    List<Map> result =
        await SQLiteDbProvider.db.getAllUsers(super.widget._userId);

    setState(() {
      for (var i = 0; i < result.length; i++) {
        _merchantWidgets.add(Recipient(
            result[i]["UserName"],
            result[i]["AccountNo"],
            result[i]["UserId"],
            widget._balance,
            widget._userId));
      }
      gotList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: (!gotList)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Pay to:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(146, 150, 153, 1),
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(children: _merchantWidgets),
                )
              ],
            ),
    );
  }
}
