import 'package:flutter/material.dart';
import 'package:nexus_app/app.dart';
import 'package:nexus_app/review.dart';
import 'package:nexus_app/landlord.dart';
import 'package:string_validator/string_validator.dart';
import 'review.dart';
import 'package:nexus_app/functionsAndData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'propImage.dart';
import 'dart:math';

//Global variables to be passed in from list of houses
int rating;
House thisHouse;

class Property extends StatefulWidget {
  Property(LatLng latlng) {
    thisHouse = getHouseFromLatLng(latlng);
  }

  // This widget is the root of your application.
  @override
  _PropertyProfile createState() => _PropertyProfile();
}

class _PropertyProfile extends State<Property> {
  final String propertyName = thisHouse.fullAddress;
  final String rating = thisHouse.avgRating.toStringAsFixed(1);
  final List<bool> selected = [true, false, false, false];

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
                      color: themeGrey),
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
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: _getImage(),
                              )),
                          SizedBox(
                            height: 12,
                          ),
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
                                      fontSize: 20.0,
                                      color: getColour(toDouble(rating))),
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
                                child: Text(thisHouse.postCode.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.left)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Last Known Landlord:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.left),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            InkWell(
                                child: Text(thisHouse.landlord,
                                    style: TextStyle(
                                        color: themeYellow,
                                        fontSize: 18,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandlordProfile(
                                            getRentierFromName(
                                                    thisHouse.landlord)
                                                .uniqueID)),
                                  );
                                }),
                            SizedBox(
                              height: 4,
                            ),
                          ])
                    ],
                  ))
            ],
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: (SizedBox(
                height: 350,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        tabs: <Widget>[
                          Tab(icon: Icon(Icons.home), text: 'Info'),
                          Tab(
                            icon: Icon(Icons.format_list_bulleted),
                            text: 'Reviews',
                          ),
                          Tab(
                            icon: Icon(Icons.image),
                            text: 'Photos',
                          ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      child: Text(
                                        '£' +
                                            (thisHouse.price / 12)
                                                .toStringAsFixed(2) +
                                            ' / month',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Bedrooms: ' +
                                            thisHouse.bedrooms.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Bathrooms ' +
                                              thisHouse.bathrooms.toString(),
                                          style: TextStyle(fontSize: 16),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 2),
                            child: ListView(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ToggleButtons(
                                      children: <Widget>[
                                        Text("  All  "),
                                        Text("  Bedrooms  "),
                                        Text("  Kitchen  "),
                                        Text("  Bills  ")
                                      ],
                                      selectedColor: Colors.white,
                                      color: Colors.white,
                                      borderColor: themeYellow,
                                      selectedBorderColor: Colors.white,
                                      renderBorder: true,
                                      fillColor: themeYellow,
                                      borderWidth: 2,
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      onPressed: (int index) {
                                        setState(() {
                                          for (int buttonIndex = 0;
                                          buttonIndex < selected.length;
                                          buttonIndex++) {
                                            if (buttonIndex == index) {
                                              selected[buttonIndex] = true;
                                            } else {
                                              selected[buttonIndex] = false;
                                            }
                                          }
                                        });
                                      },
                                      isSelected: selected,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    //Row(
                                    //children: <Widget>[
                                    SizedBox(height: 7),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: 
                                        reviewContainer(),                               
                                        )
                                      //],
                                    //)
                                  //],
                                  //)
                                  ],
                                )
                              ],
                            )
                          ),
                          Container(
                            //todo ALEX YOUR STUFF GOES HERE
                            //This container corresponds to the 3rd tab!
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: <Widget>[
                                // the following lines are hard coded shit for presentation purposes
                                //TODO replace these because they're not good
                                if (thisHouse.latlng ==
                                    LatLng(51.374515, -2.377066))
                                  for (var i = 0; i < 15; i++)
                                    FlatButton(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5.0, 0, 5.0, 0),
                                            child: Image.asset(
                                                'assets/House 1/prop1 $i.jpg')),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ImageDisplay(
                                                    'assets/House 1/prop1 $i.jpg')))),

                                if (thisHouse.latlng ==
                                    LatLng(51.380551, -2.37488))
                                  for (var i = 0; i < 20; i++)
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                        child: Image.asset(
                                            'assets/House 2/prop2 $i.jpg')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        //heroTag commented out, was breaking code
        //heroTag: thisHouse.reviews[1].toString() + 55.toString(),
        elevation: 0.0,
        child: Icon(Icons.add),
        //backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            //goes to review; passes lat and long into the class
            MaterialPageRoute(
                builder: (context) => ReviewPage(thisHouse.latlng)),
          );
        },
        splashColor: Colors.lightGreen,
      ),
    );
  }

  Widget _getImage() {
    if (thisHouse.latlng == LatLng(51.374515, -2.377066)) {
      return Image.asset('assets/House 1/prop1 15.jpg');
    }
    if (thisHouse.latlng == LatLng(51.380551, -2.37488)) {
      return Image.asset('assets/House 2/prop2 17.jpg');
    }
    return Icon(Icons.image);
  }
}

Color getColour(double num) {
  if (num >= 3.8) return Colors.green;
  if (num > 2.5)
    return Colors.orange;
  else
    return Colors.red;
}

Widget getRow(String review, double rating) {
  var random = new Random().nextInt(1000);
  return RichText(
    text: TextSpan(children: [
      WidgetSpan(
        child: Container(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              heroTag: review.toString() + random.toString(),
              backgroundColor: Colors.white,
              splashColor: Colors.blueAccent,
              onPressed: null,
              child: Text(
                rating.toString(),
                style: TextStyle(fontSize: 11.0, color: getColour(rating)),
                textAlign: TextAlign.start,
              ),
            )),
      ),
      TextSpan(text: "      " + review)
    ]),
  );
}

List<Container> reviewContainer(){
  List<Container> out = [];
  if(thisHouse.reviews == null){
      out.add(Container(
        child: Text("No Reviews found for this property!"),
        ));
  }
  else{
    for (var i in thisHouse.reviews)
      out.add(Container(
        //width:MediaQuery.of(context).size.width *0.8,
        padding:
        EdgeInsets.symmetric(vertical: 10),
        child: getRow(i.review, i.rating),
        //child: Text(i.review),
      )
      );
  }
  return out;
}