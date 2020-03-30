import 'package:flutter/material.dart';
import 'package:nexus_app/app.dart';

// a help page, implemented in response to preliminary heuristic evaluation of application
// •


String aboutText1 = "Rental Nexus is an independent tool to help you make the best decisions about your student property. Knowing a rental house has four bedrooms isn’t enough to know if that property is going to make you happy and provide a comfortable environment for a year of your studies."; 
String aboutText2 = "If you’re looking at a property, we want to put you in contact with previous residents who can tell you exactly what their experiences were. If you’ve lived in a property for a while now, and you want to share your experiences, we offer a platform to do so. Maybe your landlord is negligent. Maybe a landlord goes above and beyond for his tenants. Maybe the house has a rat issue. Maybe the advert for the house just isn’t very informative."; 
String aboutText3 = "Whatever the issue, we want students to be informed of it. That's why we've created this platform, in the hopes of building a country-wide community to make that a reality"; 
String howTo = "In it's current iteration the app is simple. We provide reviews for properties and landlords, accessible from either the map or list views. \n \n You may also add profiles for properties and landlords if they're not already here, and provide your own ratings and information about them.";
class HelpPage extends StatelessWidget {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: Text("Help"),
        
        
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: <Widget>[
          SizedBox(
            child: Image(image: AssetImage('assets/1x/logo.png'),
            height: 106,
            ),
           ),
                 
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "What is Rental Nexus?",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: themeYellow,
                ),              
                ),

          ),
          RichText(
            text: TextSpan(text: aboutText1),
          ),
          SizedBox(height: 12.0),
          RichText(
            text: TextSpan(text: aboutText2),
          ),
          SizedBox(height: 12.0),
          RichText(
            text: TextSpan(text: aboutText3),
          ),
          SizedBox(height: 12.0),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "How do I use the app?",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: themeYellow)
                ),
          ),
          RichText(
            text: TextSpan(text: howTo),
          ),
        ],
      ),
    );
  }
}