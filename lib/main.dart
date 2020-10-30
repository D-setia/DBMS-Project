import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ooad_project/login_page.dart';
import 'package:ooad_project/recipient_list.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:ooad_project/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this._userId, {Key key, this.title}) : super(key: key);
  final String title;
  final int _userId;
  final Widget visaSvg = new SvgPicture.asset(
    'assets/visaLogo.svg',
  );

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _name = "Username";
  int _accountNo = 12345;
  double _balance = 0.0;
  int bal = 0;
  bool gotData = false;
  String _cardType = "Visa";
  int _userId;
  @override
  void initState() {
    super.initState();
    displayDetails();
  }

  void displayDetails() async {
    if (!gotData) {
      List<Map> result =
          await SQLiteDbProvider.db.getAccountDetails(super.widget._userId);
      List<Map> result2 = await SQLiteDbProvider.db.getCardDetails(120724954);
      print("BOOB");
      print(result2);
      print("BOOB");
      _userId = super.widget._userId;
      print("OPPAI");
      print(result);
      print("OPPAI");
      setState(() {
        _name = result[0]['UserName'];
        _accountNo = result[0]['AccountNo'];
        _balance = result[0]['Balance'];
        gotData = true;
      });
    }
    List<Map> cardDetails =
        await SQLiteDbProvider.db.displayAllCards(_accountNo);
    print(cardDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 40,
              ),
              title: Text("New Card"),
              onTap: addNewCard,
            ),
            ListTile(
              leading: Icon(
                Icons.add,
                size: 40,
              ),
              title: Text("New Payment"),
              onTap: newPayment,
            ),
          ],
        ),
      ),
      body: (!gotData)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                    child: Text(
                      "Credit Card Processing System",
                      style: TextStyle(
                          fontSize: 60.0,
                          color: Colors.white,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      )),
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
                          height: 50.0,
                          width: 80.0,
                          child: widget.visaSvg,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                        child: Container(
                          height: 50.0,
                          width: 80.0,
                          child: Image.asset("assets/masterCardLogo.jpg"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                        child: Container(
                          height: 50.0,
                          width: 80.0,
                          child: Image.asset("assets/americanExpressLogo.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                        child: Container(
                          height: 50.0,
                          width: 80.0,
                          child: Image.asset(
                            "assets/discoverLogo.jpg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(238, 242, 245, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(146, 150, 153, 1),
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
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 20.0, 2.0, 2.0),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(146, 150, 153, 1),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 4.0),
                            child: Text(
                              "$_name",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.85),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                            child: Text(
                              "Account Number",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(146, 150, 153, 1),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 4.0),
                            child: Text(
                              "xxxxxxxxxxxxxxx${_accountNo % 10000}",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.85),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                            child: Text(
                              "Balance",
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
                              "Rs. $_balance",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: const Color.fromRGBO(0, 0, 0, 0.85),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: newPayment,
        icon: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
        label: Text(
          "New Payment",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  void newPayment() {
    Navigator.push(
        this.context,
        MaterialPageRoute(
            builder: (context) => RecipientList(_balance, _userId)));
  }

  void addNewCard() {
    Navigator.of(this.context).pop();
    showDialog(
        context: this.context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Select Card Type"),
              content: Container(
                  height: 60,
                  child: AddCardDialog((newValue) => setState(() {
                        _cardType = newValue;
                      }))),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.blue,
                  ),
                  child: FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.blue,
                  ),
                  child: FlatButton(
                    child: Text(
                      "Add Card",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Confirm New Card"),
                                content: Text("Card Type : $_cardType"),
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: Colors.blue,
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: Colors.blue,
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        var rng2 = new Random();
                                        int cardNo =
                                            rng2.nextInt(900000000) + 100000000;
                                        bool cardExists = await SQLiteDbProvider
                                            .db
                                            .checkCardExist(cardNo);

                                        while (cardExists) {
                                          cardNo = rng2.nextInt(900000000) +
                                              100000000;
                                          cardExists = await SQLiteDbProvider.db
                                              .checkCardExist(cardNo);
                                        }
                                        var rng3 = new Random();
                                        int cvv = rng3.nextInt(900) + 100;

                                        var rng4 = new Random();
                                        int month = rng4.nextInt(12) + 1;

                                        var rng5 = new Random();
                                        int year = rng5.nextInt(10) + 21;
                                        SQLiteDbProvider.db.generateCard(
                                            _accountNo,
                                            cardNo,
                                            month.toString() +
                                                "/" +
                                                year.toString(),
                                            cvv,
                                            _cardType);
                                        Toast.show("New Card Issued", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      },
                                    ),
                                  ),
                                ],
                              ));
                    },
                  ),
                )
              ],
            ));
  }
}

class AddCardDialog extends StatefulWidget {
  final Function(String newValue) _onChanged;

  const AddCardDialog(this._onChanged, {Key key}) : super(key: key);
  @override
  _AddCardDialogState createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  String _cardType = "Visa";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _cardType,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 30,
      onChanged: (String newValue) {
        setState(() {
          _cardType = newValue;
        });
        widget._onChanged(newValue);
      },
      items: <String>["Visa", "MasterCard", "American Express", "Discover"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 0.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }).toList(),
    );
  }
}
