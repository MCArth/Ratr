import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
              child: Column(
                  children: <Widget> [
                    Expanded(
                      child: Container(
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
                            SizedBox(height: 12.0,),
                            FloatingActionButton.extended(
                                icon: Icon(Icons.person),
                                label: Text('Landlord Profile (test)'),
                                heroTag: "donkey",
                                onPressed: () {
                                  Navigator.pushNamed(context,'/land');
                                }
                            ),
                          ],),

                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     alignment: Alignment(0.0,1.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         RaisedButton(
                    //           onPressed: (){},
                    //           child: Text('Add New Property')
                    //         ),
                    //         const SizedBox(width: 20,),
                    //         RaisedButton(
                    //           onPressed: (){},
                    //           child: Text('Add New Landlord')
                    //         ),
                    //       ]
                    //     ),
                    //   )
                    // ),
                  ]
              )
          )
      ),
      floatingActionButton: SpeedDial(
          child: Icon(Icons.add),
          children: [
            SpeedDialChild(
                child: Icon(Icons.home),
                label: 'New Property',
                labelStyle: TextStyle(color: Colors.blueGrey[800]),
                onTap: () => print("Go to property creation")
            ),
            SpeedDialChild(
                child: Icon(Icons.person_add),
                label: 'New Landlord',
                labelStyle: TextStyle(color: Colors.blueGrey[800]),
                onTap: () => print("Go to landlord creation")
            )
          ]
      ),
    );
  }
}