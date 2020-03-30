import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'functionsAndData.dart';
import 'app.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    fetchHouses();
    fetchLandlords();
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Rental Nexus"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            color: themeYellow,
            onPressed: () {
              Navigator.pushNamed(context,'/help');}
            )

        ]
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget> [ 
              Expanded(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: <Widget>[
                      //TODO implement search bar here 
                      SizedBox(height: 24.0),
                      FloatingActionButton.extended(
                        icon: Icon(Icons.map,color: themeYellow,),
                        backgroundColor: themeGrey,
                        label: Text('Property Map',style: TextStyle(color: Colors.white,fontSize: 18.0)),
                        heroTag: "mapbtn",
                        onPressed: () {
                          //Navigate to map page
                          Navigator.pushNamed(context,'/map');
                        }
                      ),
                      SizedBox(height: 12.0,),
                      FloatingActionButton.extended(
                        icon: Icon(Icons.list,color: themeYellow,),
                        backgroundColor: themeGrey,
                        label: Text('Properties',style: TextStyle(color: Colors.white,fontSize: 18.0)),
                        heroTag: "listbtn",
                        onPressed: () {
                          Navigator.pushNamed(context,'/list');
                        }
                      ),
                      SizedBox(height: 12.0,),
                      FloatingActionButton.extended(
                        icon: Icon(Icons.person,color: themeYellow,),
                        backgroundColor: themeGrey,
                        label: Text('Landlords',style: TextStyle(color: Colors.white,fontSize: 18.0)),
                        heroTag: "landlordlst",
                        onPressed: () {
                          Navigator.pushNamed(context,'/rentierList');
                        }
                        ),
                        
              ],),
            ),
              ),
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
          onTap: () => Navigator.pushNamed(context, '/addProp')
        ),
        SpeedDialChild(
          child: Icon(Icons.person_add),
          label: 'New Landlord',  
          labelStyle: TextStyle(color: Colors.blueGrey[800]),
          onTap: () => Navigator.pushNamed(context, '/addLand')
        )
      ]
    ), 
    );
  }
}
