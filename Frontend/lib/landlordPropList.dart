import 'package:flutter/material.dart';
import 'package:nexus_app/prop.dart';
import 'functionsAndData.dart';

int lpIndex;

/*
Page displaying each property a landlord owns
 */
class LandProp extends StatelessWidget{

  LandProp(int index) {
    lpIndex = index;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: new AppBar(
            title: Text("Properties")),
        body: getRentierListViewBody(context)
    );
  }
}

//Generates an instance of a card for a house
makeRentierCard(BuildContext context, int index){
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 6.0,
    ),
    child: Container(
      decoration: BoxDecoration(
      ),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.home, color: Colors.white),
          ),
          title: Text(
            //(houseList[index].houseNum.toString() + " " + houseList[index].street),
            //todo change this in functions and data
            landlordList[lpIndex].houses[index].toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Text(landlordList[index].houses.length.toString())
            ],
          ),
          //todo address potential issue with passing in index
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            //Navigator.pushNamed(context, '/property');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Property(index)),
            );
          }
      ),
    ),
  );
}

//Function that gets all houses from database, creates card for each one
Widget getRentierListViewBody(BuildContext context){
  return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: landlordList[lpIndex].houses.length,
        itemBuilder: (BuildContext context, int index){
          return makeRentierCard(context,index);
        },
      )
  );
}