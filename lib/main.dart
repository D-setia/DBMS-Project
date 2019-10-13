import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ooad_project/recipient_list.dart';
import 'package:http/http.dart' as http;



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final Widget visaSvg = new SvgPicture.asset(
    'assets/visaLogo.svg',
  );

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _name = "Username";
  int _accountNoEnd = 12345;
  double _balance = 0.0;
  int bal = 0;
  bool gotData = false;

  @override
  void initState(){
    super.initState();
    if(!gotData) {
      http.get('https://ooadproject-3324c.firebaseio.com/user.json')
          .then((http.Response response) {
        final Map<String, dynamic> userDetails = jsonDecode(response.body);
        setState(() {
          _name = userDetails['name'];
          _accountNoEnd = userDetails['accNo'];
          _balance = userDetails['balance'];
          gotData = true;
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: (!gotData)?
        Center(
          child: CircularProgressIndicator(),
        )
            :
        ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                child: Text(
                  "Credit Card Processing System",
                  style: TextStyle(
                      fontSize: 60.0,
                      color: Colors.white,
                      fontFamily: 'Montserrat'
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )
              ),
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
                      child: Image.asset(
                          "assets/masterCardLogo.jpg"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                    child: Container(
                      height: 50.0,
                      width: 80.0,
                      child: Image.asset(
                          "assets/americanExpressLogo.png"
                      ),
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
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Details",
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
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 2.0, 2.0),
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
                        padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 4.0),
                        child: Text(
                          "$_name",
                          style: TextStyle(
                              fontSize: 24.0,
                              color: const Color.fromRGBO(0, 0, 0, 0.85),
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
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
                        padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 4.0),
                        child: Text(
                          "xxxxxxxxxxxxxxx$_accountNoEnd",
                          style: TextStyle(
                              fontSize: 24.0,
                              color: const Color.fromRGBO(0, 0, 0, 0.85),
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
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
                        padding: const EdgeInsets.fromLTRB(20.0, 4.0, 30.0, 15.0),
                        child: Text(
                          "Rs. $_balance",
                          style: TextStyle(
                              fontSize: 24.0,
                              color: const Color.fromRGBO(0, 0, 0, 0.85),
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => RecipientList(_balance)));
          },
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
}
