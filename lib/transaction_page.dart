import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ooad_project/confirm_payment_page.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class MakePayment extends StatefulWidget{

  final double _amount;
  final String _receiverName;
  final double _balance;

  MakePayment(this._amount, this._receiverName, this._balance);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  String name;
  final nameController = TextEditingController();

  int cardNo;
  final cardNoController = TextEditingController();

  String expiryDate;
  final expiryDateController = TextEditingController();

  int cvv;
  final cvvController = TextEditingController();

  bool isAuthenticating = false;



  final Widget visaSvg = new SvgPicture.asset(
      'assets/visaLogo.svg',
      semanticsLabel: 'Acme Logo'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Credit Card Processing"),
        ),
        body:
        (isAuthenticating)?
        Center(
          child: CircularProgressIndicator(),
        )
            :
        ListView(
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
                            "Pay Invoice",
                            style: TextStyle(
                              color: const Color.fromRGBO(146, 150, 153, 1),
                              fontSize:22.0,
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
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                            child: Container(
                              height: 30.0,
                              width: 50.0,
                              child: visaSvg,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                            child: Container(
                              height: 30.0,
                              width: 50.0,
                              child: Image.asset(
                                  "assets/mastercardLogo.jpg"
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                            child: Container(
                              height: 30.0,
                              width: 50.0,
                              child: Image.asset(
                                  "assets/americanExpressLogo.png"
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                            child: Container(
                              height: 30.0,
                              width: 50.0,
                              child: Image.asset(
                                "assets/discoverLogo.jpg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 2.0, 2.0, 2.0),
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
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 2.0),
                      child: Text(
                        "Name on card",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(146, 150, 153, 1),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 15.0),
                      child: TextField(
                        controller: nameController,
//                        onChanged: (ip){
//                          name = ip;
//                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(146, 150, 153, 1),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 2.0),
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
                      padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 15.0),
                      child: TextField(
                        controller: cardNoController,
//                        onChanged: (ip){
//                          cardNo = int.parse(ip);
//                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(146, 150, 153, 1),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              )
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 2.0),
                              child: Text(
                                "Expiry Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(146, 150, 153, 1),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 36.0),
                              child: Container(
                                width: 180.0,
                                child: TextField(
                                  controller: expiryDateController,
//                                  onChanged: (ip){
//                                    expiryDate = ip;
//                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color.fromRGBO(146, 150, 153, 1),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          )
                                      ),
                                      hintText: ""
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 2.0),
                              child: Text(
                                "CVV",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(146, 150, 153, 1),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 4.0, 30.0, 15.0),
                              child: Container(
                                width: 100.0,
                                child: TextField(
                                  controller: cvvController,
//                                  onChanged: (ip){
//                                    cvv = int.parse(ip);
//                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color.fromRGBO(146, 150, 153, 1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  obscureText: true,
                                  maxLength: 3,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
              child: RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  color: const Color.fromRGBO(3, 169, 244, 0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.lock_outline,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        Text(
                          "Pay Rs. ${widget._amount}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    if((nameController.text == "")||
                        (expiryDateController.text == "")||
                        (cardNoController.text == "")||
                        (cvvController.text == "")){
                      Toast.show("Enter all fields", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    }else{
                      setState(() {
                        isAuthenticating = true;
                      });
                      http.get('https://ooadproject-3324c.firebaseio.com/cardDetails.json')
                          .then((http.Response response){
                        final Map<String, dynamic> cardDetails = jsonDecode(response.body);
                        print(nameController.text);
                        print(int.parse(cardNoController.text));
                        print(expiryDateController.text);
                        print(cvvController.text);
                        if(
                        (cardDetails['name'] == nameController.text)&&
                            (cardDetails['number'] == int.parse(cardNoController.text))&&
                            (cardDetails['cvv'] == int.parse(cvvController.text))&&
                            (cardDetails['expiryDate'] == expiryDateController.text)){
                          print(cardNoController.toString());
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => ConfirmPayment(int.parse(cardNoController.text)%1000, widget._amount, widget._receiverName, widget._balance)));
                        }
                      });
                    }
                  }
              ),
            )
          ],
        )
    );
  }

  @override
  void dispose(){
    nameController.dispose();
    cardNoController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}
