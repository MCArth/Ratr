<<<<<<< HEAD
import 'package:flutter/material.dart';


//page displaying all available properties in a relational database
//required to display only a small amount of information that nevertheless expresses the general sense for a property at a glance
//Maybe use tiles to display an image + price per month + an address
class ListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
=======
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
          child: getListViewBody(context)
        )

      );
  }


}

getListViewBody(BuildContext context){

>>>>>>> samsbranch
}