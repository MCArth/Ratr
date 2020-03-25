import 'package:flutter/material.dart';
import 'package:nexus_app/list.dart';
import 'package:nexus_app/functionsAndData.dart';
import 'package:nexus_app/revland.dart';
import 'package:string_validator/string_validator.dart';

int landIndex;

class LandlordProfile extends StatelessWidget {

  LandlordProfile(int index) {
    landIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return _LandlordProfile();
  }
}

class _LandlordProfile extends StatelessWidget {
  //todo change this
  final String name = landlordList[landIndex].name.toString();
  final String rating = landlordList[landIndex].avgRating.toString();
  //todo finish this
  //final String number = landlordList[landIndex]

  Color getColour(double num) {
    if (num >= 7.5) return Colors.green;
    if (num > 5) return Colors.orange;
    else return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: Text(
          name,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 23.0),
                decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.all(
                  Radius.circular(7.0)
                ), color: Colors.grey[350]),
                //color: Colors.grey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          //todo this is just a place holder
                          name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          height: 55,
                          width: 55,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            splashColor: Colors.blueAccent,
                            onPressed: () {},
                            child: Text(
                              rating,
                              style: TextStyle(
                                  fontSize: 20.0, color: getColour(toDouble(rating))),
                            ),
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      //]),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 80,
                            ),
                            Container(
                              child: Text(
                                //todo continue
                                'Number of Properties: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            Container(
                              child: Text(
                                //var number
                                '5',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        child: Text(
                          'List of Properties',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {//todo stuff goes here, should go to a list view of houses?
                          Navigator.push(
                            context,
                            //goes to review; passes lat and long into the class
                            //todo change this theme is fucked!!!!
                            MaterialPageRoute(builder: (context) => ListPage()),
                          );
                           }
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(height: 35),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Landlord Information:',
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
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Landlord Experiences:',
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
          SizedBox(height: 35),
          Container(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    heroTag: "dog",
                    elevation: 0.0,
                    child: Icon(Icons.add),
                    //backgroundColor: Colors.orange,
                    onPressed: () {
                      //todo this goes to wrong review page lol
                      //todo must change
                      Navigator.push(
                        context,
                        //goes to review; passes lat and long into the class
                        MaterialPageRoute(builder: (context) => LandlordReview()),
                      );
                    },
                  )))
        ],
      )),
    );
  }
}
