import 'package:flutter/material.dart';
import 'package:ooad_project/transaction_page.dart';
import 'package:toast/toast.dart';

class NewPayment extends StatelessWidget{

  final String _receiverName;
  final int _randInt;
  final double _balance;
  double amount = 0.0;

  NewPayment(this._receiverName, this._randInt, this._balance, {Key key}) : super(key: key);

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
      body: Container(
        color: Colors.blue,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      child: Center(
                        child: Text(
                          "G",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                        color: getColor(_randInt),
                      ),
                      child: Center(
                        child: Text(
                          "${_receiverName[0]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Paying $_receiverName",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 8.0),
                      child: Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      width: 100.0,
                      child: Center(
                        child: TextField(
                          onChanged: (ip){
                            amount = double.parse(ip);
                          },
                          keyboardType: TextInputType.numberWithOptions(decimal: true,),
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: "0",
                            hintStyle: TextStyle(
                              fontSize: 50.0,
                              color: const Color.fromRGBO(255, 255, 255, 0.65),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                  child: RaisedButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.check,
                            size: 30.0,
                            color: Colors.blue,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Pay",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blue
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      if(amount == 0.0){
                        Toast.show("Please select non-zero amount", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }else if(amount > _balance){
                        Toast.show("Insufficient Balance!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }else{
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => MakePayment(amount, _receiverName, _balance)));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
