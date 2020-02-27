import 'package:flutter/material.dart';

void main() => runApp(Property());

class Property extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Profile',
      home: PropertyProfile(),
    );
  }
}

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12.0),
                      ),
                      Container(
                          child: Icon(
                        Icons.home,
                        size: 100,
                      ))
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
                      onPressed: () {})
                ],
              )
            ]),
      ),
    );
  }
}
