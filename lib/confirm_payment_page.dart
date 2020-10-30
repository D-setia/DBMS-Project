import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ooad_project/transaction_complete.dart';
import 'package:http/http.dart' as http;
import 'package:ooad_project/database.dart';

class ConfirmPayment extends StatefulWidget {
  final int _cardNumber;
  final double _amount;
  final String _receiverName;
  final double _balance;
  final int _userId;
  const ConfirmPayment(this._cardNumber, this._amount, this._receiverName,
      this._balance, this._userId,
      {Key key})
      : super(key: key);

  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  final String _cardAssociation = "visa";
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return
//      (isUpdating)?
//    Center(
//      child: CircularProgressIndicator(),
//    )
//        :
        Scaffold(
      appBar: AppBar(
        title: Text("Credit Card Processing"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: const Color.fromRGBO(238, 242, 245, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Confirm Details",
                          style: TextStyle(
                            color: const Color.fromRGBO(146, 150, 153, 1),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: const Color.fromRGBO(146, 150, 153, 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 2.0, 2.0),
                    child: Text(
                      "Payment Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(146, 150, 153, 1),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 4.0, 2.0, 15.0),
                    child: Text(
                      "Rs. ${widget._amount}",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: const Color.fromRGBO(0, 0, 0, 0.85),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 2.0),
                    child: Text(
                      "Paying to",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(146, 150, 153, 1),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 15.0),
                    child: Text(
                      "${widget._receiverName}",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: const Color.fromRGBO(0, 0, 0, 0.85),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 2.0),
                            child: Text(
                              "Card Number",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(146, 150, 153, 1),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 4.0, 30.0, 15.0),
                            child: Text(
                              "XXXX XXXX XXXX ${widget._cardNumber}",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.85),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 8.0, 15.0, 8.0),
                        child: Container(
                          height: 30.0,
                          width: 50.0,
                          child: getCardAssociation(_cardAssociation),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            child: RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Pay",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () {
                Toast.show("Processing. Please wait...", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

                final Map<String, dynamic> updateUserDetails = {
                  'name': "Group 18",
                  'balance': (widget._balance - widget._amount),
                  'accNo': 83639
                };
                SQLiteDbProvider.db.debitAmount(
                    widget._cardNumber, widget._balance - widget._amount);
                SQLiteDbProvider.db
                    .creditAmount(widget._receiverName, widget._amount);
                // http
                //     .put('https://ooadproject-3324c.firebaseio.com/user.json',
                //         body: jsonEncode(updateUserDetails))
                //     .then((http.Response response) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TransactionComplete(widget._userId)));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            child: RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )
                  ],
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getCardAssociation(String cardAssociation) {
    switch (cardAssociation) {
      case "visa":
        return SvgPicture.asset('assets/visaLogo.svg',
            semanticsLabel: 'Acme Logo');
        break;
      case "mastercard":
        return Image.asset("assets/masterCardLogo.jpg");
        break;
      case "americanexpress":
        Image.asset("assets/americanExpressLogo.png");
        break;
      default:
        return Image.asset(
          "assets/discoverLogo.jpg",
        );
    }

    return null;
  }
}
