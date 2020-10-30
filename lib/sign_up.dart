import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ooad_project/main.dart';
import 'package:ooad_project/database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  String _cardType = "Visa";
  bool _isSignUpTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: !_isSignUpTapped,
                decoration: InputDecoration(
                  labelText: 'Enter Username',
                  border: OutlineInputBorder(),
                  labelStyle:
                      TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                ),
                validator: (value) => value.isEmpty
                    ? 'Username can\'t be empty'
                    : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]")
                            .hasMatch(value)
                        ? null
                        : "Enter a valid username!",
                onSaved: (value) => _username = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: !_isSignUpTapped,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                  labelStyle:
                      TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                ),
                validator: (value) =>
                    value.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Select Card Type",
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.grey),
                    ),
                  ),
                  Container(
                    height: 60,
                    child: DropdownButton<String>(
                      value: _cardType,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 30,
                      onChanged: (String newValue) {
                        setState(() {
                          _cardType = newValue;
                        });
                      },
                      items: <String>[
                        "Visa",
                        "MasterCard",
                        "American Express",
                        "Discover"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 0.0),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: FlatButton(
                color: _isSignUpTapped ? Colors.white70 : Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      'SIGN UP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color:
                            _isSignUpTapped ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: _validateAndSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      setState(() {
        _isSignUpTapped = true;
      });
      //TODO : Put new account in db
      var rng = new Random();
      int code = rng.nextInt(900000000) + 100000000;
      print("CHECKS");
      bool exists = await SQLiteDbProvider.db.checkAccountExist(code);

      while (exists) {
        code = rng.nextInt(900000000) + 100000000;
        exists = await SQLiteDbProvider.db.checkAccountExist(code);
      }
      int newUserId =
          await SQLiteDbProvider.db.insertLogin(_username, _password);
      print("CHECK");
      print(newUserId);
      print("CHECK");
      int accountNo = await SQLiteDbProvider.db.createAccount(newUserId, code);
      print("BOOB");
      print(accountNo);
      print("BOOB");

      var rng2 = new Random();
      int cardNo = rng2.nextInt(900000000) + 100000000;
      print("CHECKS");
      bool cardExists = await SQLiteDbProvider.db.checkCardExist(cardNo);

      while (cardExists) {
        cardNo = rng2.nextInt(900000000) + 100000000;
        cardExists = await SQLiteDbProvider.db.checkCardExist(cardNo);
      }

      var rng3 = new Random();
      int cvv = rng3.nextInt(900) + 100;

      var rng4 = new Random();
      int month = rng4.nextInt(12) + 1;

      var rng5 = new Random();
      int year = rng5.nextInt(10) + 21;
      SQLiteDbProvider.db.generateCard(accountNo, cardNo,
          month.toString() + "/" + year.toString(), cvv, _cardType);
      setState(() {
        _isSignUpTapped = false;
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => new MyHomePage(
                      newUserId,
                      title: "CCPS Demo Home Page",
                    )
                //TODO: put correct user_id
                ));
      });
    }
  }
}
