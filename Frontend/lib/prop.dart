import 'package:flutter/material.dart';
import 'package:nexus_app/review.dart';
import 'package:string_validator/string_validator.dart';
import 'review.dart';
import 'package:nexus_app/functionsAndData.dart';

//void main() => runApp(Property());

//Global variables to be passed in from list of houses
int propIndex;
int rating;
double widthScreen;

class Property extends StatelessWidget {
  Property(int index) {
    propIndex = index;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return PropertyProfile();
  }
}

class PropertyProfile extends StatelessWidget {
  final String propertyName = houseList[propIndex].houseNum.toString() +
      " " +
      houseList[propIndex].street.toString();
  final String rating = houseList[propIndex].avgRating.toString();

  Color getColour(double num) {
    if (num >= 3.8) return Colors.green;
    if (num > 2.5) return Colors.orange;
    else return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: Text(
          propertyName,
          //propertyName+propLat.toString(),
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: Colors.black),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0, vertical: 1.0),
                      ),
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                              child: Icon(
                                //todo property image goes here
                                Icons.image,
                                size: 75,
                              )),
                          SizedBox(height: 12,),
                          Container(
                              height: 60,
                              width: 60,
                              child: FloatingActionButton(
                                heroTag: 'idekwhatthisis',
                                backgroundColor: Colors.white,
                                splashColor: Colors.blueAccent,
                                onPressed: () {},
                                child: Text(
                                  rating,
                                  style: TextStyle(
                                      fontSize: 20.0, color: getColour(toDouble(rating))),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(width: 40.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(propertyName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                                child: Text(
                                    houseList[propIndex].postCode.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.left)),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: Text('Last Known Landlord:',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.left),
                            ),
                            Container(
                              child: Text(houseList[propIndex].landlord,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                            ),
                            SizedBox(
                              height: 4,
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
                              //todo change or delete this if no backend change
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
          SizedBox(height: 10),
          DefaultTabController(
            length: 2,
            child: (SizedBox(
                height: 250,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        tabs: <Widget>[
                          Tab(icon: Icon(Icons.home), text: 'Info'),
                          Tab(
                            icon: Icon(Icons.format_list_bulleted),
                            text: 'Reviews',
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            height: 80,
                            child: ListView(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2),
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Align(
                                      child: Text('Price: ' +
                                          '£' +
                                          (houseList[propIndex].price / 12)
                                              .toString()),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Bedrooms: ' +
                                      houseList[propIndex].bedrooms.toString()),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Bathrooms ' +
                                      houseList[propIndex].bathrooms.toString(),)
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (var i in houseList[propIndex].reviews)
                                      Container(
                                        width: widthScreen*0.7,
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(i.review),
                                      ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (var i in houseList[propIndex].reviews)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                        child: Text(i.rating.toString()),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            //child: Text('Dog'),
                          )
                        ],
                      ),
                    )
                  ],
                ))),
          ),
          SizedBox(height: 50),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                elevation: 0.0,
                child: Icon(Icons.add),
                //backgroundColor: Colors.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    //goes to review; passes lat and long into the class
                    MaterialPageRoute(
                        builder: (context) => ReviewPage(propIndex)),
                  );
                },
                splashColor: Colors.lightGreen,
              ))
        ],
      )),
    );
  }
}
