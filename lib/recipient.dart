import 'package:flutter/material.dart';
import 'package:ooad_project/new_payment_page.dart';

class Recipient extends StatelessWidget{

  final String _name;
  final int _accountNo;
  final int _randomColor;
  final double _balance;

  Recipient(this._name, this._accountNo, this._randomColor, this._balance);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                      color: getColor(_randomColor),
                    ),
                    child: Center(
                      child: Text(
                        "${_name[0]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 2.0),
                          child: Text(
                            "$_name",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Text(
                            "xxxxxxxxxxxxxxx$_accountNo",
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 0.65),
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: const Color.fromRGBO(146, 150, 153, 1),
              height: 1.0,
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => NewPayment(_name, _randomColor, _balance)));
      },
    );
  }

  MaterialColor getColor(int randInt) {
    switch(randInt){
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.deepOrange;
        break;
      case 3:
        return Colors.amber;
        break;
      case 4:
        return Colors.deepPurple;
        break;
      case 5:
        return Colors.indigo;
        break;
      case 6:
        return Colors.lightGreen;
        break;
      case 7:
        return Colors.lime;
        break;
      case 8:
        return Colors.orange;
        break;
      case 9:
        return Colors.pink;
        break;
      case 10:
        return Colors.purple;
        break;
      case 11:
        return Colors.teal;
        break;
      default:
        return Colors.yellow;
    }
  }
}
