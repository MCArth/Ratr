import 'package:flutter/material.dart';

class addLandlord extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _addLandlord();
}

class _addLandlord extends State<addLandlord>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Landlord"),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  //TODO: First and last name
                  //email
                  //dob
                  //address
                ],
              ),
            ),
          )
      ),
    );
  }
}