import 'package:flutter/material.dart';
import 'package:nexus_app/landlord.dart';
import 'functionsAndData.dart';
import 'package:nexus_app/app.dart';

//page displaying all available properties in a relational database
//required to display only a small amount of information that nevertheless expresses the general sense for a property at a glance
//Maybe use tiles to display an image + price per month + an address
class RentierListPage extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: Text("Landlords we know about")),
        body: getRentierListViewBody(context)
        );
  }
}

//Generates an instance of a card for a house
makeLandlordCard(BuildContext context, int index){
  print(index);
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 6.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: themeGrey,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: themeYellow))),
                  child: Icon(Icons.person, color: Colors.white,size: 40.0),
                ),
                title: Text(
                  (landlordList[index].name),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),

                subtitle: Row(
                  children: <Widget>[
                    Text("Has " + landlordList[index].houses.length.toString() + " known property")
                  ],
                ),
                trailing:
                    Icon(Icons.keyboard_arrow_right, color: themeYellow, size: 50.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandlordProfile(index)),
                  );
                        }
        ),
      ),
  );
}

//Function that gets all houses from database, creates card for each one
Widget getRentierListViewBody(BuildContext context){
  return Column(children: <Widget>[
    SizedBox(height: 10),
    Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: landlordList.length,
        itemBuilder: (BuildContext context, int index){
          return makeLandlordCard(context,index);
        },
      )
  ),
  ]
  );
}