import 'package:flutter/material.dart';
//
//import 'main.dart';
//import 'main.dart';
//
//void main() => runApp(Property());

//class Property extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Property Profile',
//      home: PropertyProfile(),
//    );
//  }
//}

class PropertyProfile extends StatelessWidget {
  final String propertyName = "Property Name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          propertyName,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.home,
                              size: 100,
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 300),
                  RaisedButton(
                      color: Colors.orange,
                      disabledColor: Colors.pink,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.blue,
                      child: Text(
                        'BACK',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(
                            context
                        );
                      })
                ],
              )
            ]),
      ),
    );
  }
}
