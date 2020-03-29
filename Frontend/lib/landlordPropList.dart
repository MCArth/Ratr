import 'package:flutter/material.dart';
import 'package:nexus_app/prop.dart';
import 'functionsAndData.dart';

int landLordID;
House house;
var themeYellow;

/*
Page displaying each property a landlord owns
 */
class LandProp extends StatelessWidget{

  LandProp(int index) {
    landLordID = index;
    themeYellow = Color(0xF9AA33).withOpacity(1);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: new AppBar(
            title: Text("Properties")),
        body: getListViewBody(context)
    );
  }
}

//Generates an instance of a card for a house
makeListCard(BuildContext context, int index){
  //ERROR IS HERE @SAM
  house = getHouseFromLatLng(landlordList[landLordID].houses[index]);
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
            child: Icon(Icons.home, color: Colors.white, size: 40,),
          ),
          title: Text(
            house.fullAddress.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Text(house.bedrooms.toString()+" Bedroom House")
            ],
          ),
          //todo address potential issue with passing in index
          trailing:
          Icon(Icons.keyboard_arrow_right, color: themeYellow, size: 50.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Property(house.latlng)),
            );
          }
      ),
    ),
  );
}

//Function that gets all houses from database, creates card for each one
Widget getListViewBody(BuildContext context){
  return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        //Might also be here?
        itemCount: landlordList[landLordID].houses.length,
        itemBuilder: (BuildContext context, int index){
          return makeListCard(context,index);
        },
      )
  );
}