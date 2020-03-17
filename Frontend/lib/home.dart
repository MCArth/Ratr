import 'package:flutter/material.dart';
import 'map.dart';


//TODO implement map and list as states of home page, with bottom navigation bar, do more encapsulation
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              //TODO implement search bar here 
              SizedBox(height: 24.0),
              FloatingActionButton.extended(
                icon: Icon(Icons.map),
                label: Text('Property Map'),
                heroTag: "mapbtn",
                onPressed: () {
                  //Navigate to map page
                  Navigator.pushNamed(context,'/map');
                }
              ),
              SizedBox(height: 12.0,),
              FloatingActionButton.extended(
                icon: Icon(Icons.list),
                label: Text('Property List'),
                heroTag: "listbtn",
                onPressed: () {
                  Navigator.pushNamed(context,'/list');
                }
              ),
              
            ],)
          ),
        )
    ); 
  }
}
