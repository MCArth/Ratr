import 'package:flutter/material.dart';
import 'package:nexus_app/prop.dart';
import 'functionsAndData.dart';
import 'app.dart';

int landLordID;
House house;
Landlord landlord;

/*
Page displaying each property a landlord owns
 */
class LandProp extends StatelessWidget{

  LandProp(int index) {
    landLordID = index;
    landlord = getRentierFromID(landLordID);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: new AppBar(
            title: Text(landlord.name+"'s Properties", style: TextStyle(
              fontSize: 19
            ),)),
        body: getListViewBody(context)
    );
  }
}

//Generates an instance of a card for a house
makeListCard(BuildContext context, int index){
  house = getHouseFromLatLng(landlord.houses[index]);
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
        itemCount: landlord.houses.length,
        itemBuilder: (BuildContext context, int index){
          return makeListCard(context,index);
        },
      )
  );
}