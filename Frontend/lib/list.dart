import 'package:flutter/material.dart';


//page displaying all available properties in a relational database
//required to display only a small amount of information that nevertheless expresses the general sense for a property at a glance
//Maybe use tiles to display an image + price per month + an address
class ListPage extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: Text("List View")),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0,10.0,0,10.0),
          child: ListView(
            children: _getListViewBody(context)
          )
        )

      );
  }


}

//Function that gets all houses from database
List<Card> _getListViewBody(BuildContext context){
  List<Card> cards;
  ListView();
  return cards;
}