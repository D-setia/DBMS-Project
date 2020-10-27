import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ooad_project/main.dart';
import 'package:ooad_project/sign_up.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  bool _isLoginTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Login"),),
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
                enabled: !_isLoginTapped,
                decoration: InputDecoration(
                  labelText: 'Enter Username',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
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
                enabled: !_isLoginTapped,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                ),
                validator: (value) => value.isEmpty
                    ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: FlatButton(
                color: _isLoginTapped? Colors.white70 : Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: _isLoginTapped ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: _validateAndSubmit,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
              child: Center(
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Create one!',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignUpPage();
                                  }));
                            })
                    ])),
              ),
            )
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

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      setState(() {
        _isLoginTapped = true;
      });
      //TODO : Access db for login
      setState(() {
        _isLoginTapped = false;
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => new MyHomePage(0000, title: "CCPS Demo Home Page",)
              //TODO: put correct user_id
            )
        );
      });
    }
  }
}
