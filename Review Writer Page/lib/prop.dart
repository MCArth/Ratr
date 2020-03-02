import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

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
  //todo change this
  final String propertyName = "Property Profile";

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.0, vertical: 12.0),
                  ),
                  Container(
                      child: Icon(
                    Icons.home,
                    size: 80,
                  )),
                  SizedBox(width: 50.0),
                  Column(children: <Widget>[
                    Container(
                      child: Text(
                          //todo this is just a place holder
                          '5 Green Street',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left),
                    ),
                    Container(
                      child: Text(
                          //todo this is just a place holder
                          'BA2 6FP',
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.left),
                    ),
                    Container(
                      child: Text('Last Known Landlord:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.left),
                    )
                  ])
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Property Information:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 4,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide:
                            BorderSide(width: 10.0, style: BorderStyle.solid)),
                    filled: true,
                    hintText: 'Stuff goes here....')
                //labelText: 'House Review')
                ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Property Experiences:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 4,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide:
                            BorderSide(width: 10.0, style: BorderStyle.solid)),
                    filled: true,
                    hintText: 'Stuff goes here....')
                //labelText: 'House Review')
                ),
          ),
          SizedBox(height: 35),
          Container(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    elevation: 0.0,
                    child: Icon(Icons.add),
                    backgroundColor: Colors.orange,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewPage()),
                      );
                    },
                  )))
        ],
      )),
    );
  }
}
