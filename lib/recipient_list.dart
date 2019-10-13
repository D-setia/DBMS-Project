import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ooad_project/merchant.dart';
import 'package:ooad_project/recipient.dart';
import 'package:http/http.dart' as http;


class RecipientList extends StatefulWidget{

  final double _balance;

  const RecipientList(this._balance, {Key key}) : super(key: key);

  @override
  _RecipientListState createState() => _RecipientListState();

}

class _RecipientListState extends State<RecipientList> {

  bool gotList = false;
  List<Merchant> _merchants = [];
  List<Widget> _merchantWidgets = [];

  @override
  void initState(){
    super.initState();
    http.get('https://ooadproject-3324c.firebaseio.com/merchants.json')
    .then((http.Response response){
      final List<Merchant> fetchedMerchantList = [];
      print(jsonDecode(response.body));
      final Map<String, dynamic> merchantList = jsonDecode(response.body);
      merchantList.forEach((String merchantNo, dynamic merchantDetails){
        final Merchant merchant = Merchant(
          merchantDetails['name'],
          merchantDetails['accNo'],
          merchantDetails['randInt']
        );
        fetchedMerchantList.add(merchant);
      });
      setState(() {
        _merchants = fetchedMerchantList;
        for(var i = 0; i < _merchants.length; i++){
          _merchantWidgets.add(
              Recipient(
                  _merchants[i].name,
                  _merchants[i].accNo,
                  _merchants[i].randInt,
                widget._balance
              )
          );
        }
        gotList = true;
      });
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
        body: (!gotList)? Center(
          child: CircularProgressIndicator(),
        )
        :
        Column(
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
              child: ListView(
                children: _merchantWidgets
              ),
            )
          ],
        ),
    );
  }

}
