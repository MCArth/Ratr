<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'map.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          }
        ),
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
                heroTag: "lstbtn",
                onPressed: () {

                }
              ),
              
            ],)
          ),
        )
    ); 
  }
}

=======
import 'package:flutter/material.dart';
import 'map.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          }
        ),
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
                onPressed: () {}
              ),
              SizedBox(height: 12.0,),
              FloatingActionButton.extended(
                icon: Icon(Icons.list),
                label: Text('Property List'),
                onPressed: () {}
              ),
              
            ],)
          ),
        )
    ); 
  }
}

>>>>>>> YassinIsCool
