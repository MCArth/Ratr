import 'package:flutter/material.dart';
import 'package:nexus_app/prop.dart';


//page displaying all available properties in a relational database
//required to display only a small amount of information that nevertheless expresses the general sense for a property at a glance
//Maybe use tiles to display an image + price per month + an address
class ListPage extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: Text("List View")),
        body: getListViewBody(context)
        );
  }
}

//Generates an instance of a card for a house
makeHouseCard(BuildContext context){
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
                  "32 Road Avenue",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text("5 Bedroom House")
                  ],
                ),
                trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                onTap: () {
                        //Navigator.pushNamed(context, '/property');
                  Navigator.push(
                    context,
                    //todo get actual lat and long; not 69,96 lol
                    MaterialPageRoute(builder: (context) => Property(69,96)),
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
      //TODO make this dynamically size house directory 
      itemCount: 10,
      itemBuilder: (BuildContext context, int index){
        return makeHouseCard(context);
      },
    )
  );
}