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
                  
              ],)
            ),
              ),
          Expanded(
            child: Container(
              alignment: Alignment(0.0,1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){},
                    child: Text('Add New Property')
                  ),
                  const SizedBox(width: 20,),
                  RaisedButton(
                    onPressed: (){},
                    child: Text('Add New Landlord')
                  ),
                ]
              ),
            )
          ),
          ]
        )
      )
    ) 
    );
  }
}
