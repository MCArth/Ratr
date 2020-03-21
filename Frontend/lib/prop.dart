import 'package:flutter/material.dart';
import 'package:nexus_app/review.dart';
import 'review.dart';

//void main() => runApp(Property());

//Global variables to be passed in from list of houses
int propLat;
int propLong;

class Property extends StatelessWidget {
  Property(int lat, int long) {
    propLat = lat;
    propLat = long;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: new AppBar(
    //   title: 'Property Profile',
    //   home: PropertyProfile(),
    // );
    return PropertyProfile();
  }
}

class PropertyProfile extends StatelessWidget {
  //todo do database stuff with lat and long
  final String propertyName = "Property Profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: Text(
          "Latitude: " + propLat.toString(),
          //propertyName+propLat.toString(),
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
              Container(
                  padding: EdgeInsets.symmetric(vertical: 23.0),
                  decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.all(
                      Radius.circular(7.0)
                  ), color: Colors.grey[350]),
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                  ),
                  Container(
                      child: Icon(
                    //todo property image goes here
                    Icons.image,
                    size: 110,
                  )),
                  SizedBox(width: 30.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                                textAlign: TextAlign.left)),
                        Container(
                          child: Text('Last Known Landlord:',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          child: Text('Roger Mexico',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          child: Text('Last Known Agency:',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          //todo get rid of hardcoding
                          child: Text('Trustease',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        )
                      ])
                ],
              ))
            ],
          ),
          SizedBox(height: 35),
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            //todo backend stuff here
            child: Text('No information yet.'),
            decoration:
                BoxDecoration(border: Border.all(), shape: BoxShape.rectangle),
//            child: TextField(
//                keyboardType: TextInputType.multiline,
//                minLines: 4,
//                maxLines: 4,
//                decoration: InputDecoration(
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(3.0),
//                        borderSide:
//                            BorderSide(width: 10.0, style: BorderStyle.solid)),
//                    filled: true,
//                    hintText: 'Stuff goes here....')
//                //labelText: 'House Review')
//                ),
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            //todo backend stuff here
            child: Text('No information yet.'),
            decoration:
                BoxDecoration(border: Border.all(), shape: BoxShape.rectangle),
          ),
//          Container(
//            padding: EdgeInsets.symmetric(vertical: 10),
//            child: TextField(
//                keyboardType: TextInputType.multiline,
//                minLines: 4,
//                maxLines: 4,
//                decoration: InputDecoration(
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(3.0),
//                        borderSide:
//                            BorderSide(width: 10.0, style: BorderStyle.solid)),
//                    filled: true,
//                    hintText: 'Stuff goes here....')
//                //labelText: 'House Review')
//                ),
//          ),
          SizedBox(height: 35),
          Container(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    elevation: 0.0,
                    child: Icon(Icons.add),
                    //backgroundColor: Colors.orange,
                    onPressed: () {
                      Navigator.push(
                        context,
                        //goes to review; passes lat and long into the class
                        MaterialPageRoute(
                            builder: (context) =>
                                ReviewPage(propLat, propLong)),
                      );
                    },
                    splashColor: Colors.lightGreen,
                  )))
        ],
      )),
    );
  }
}
