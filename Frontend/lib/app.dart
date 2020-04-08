import 'package:flutter/material.dart';
import 'package:nexus_app/addLandlord.dart';
import 'package:nexus_app/addProperty.dart';
import 'package:nexus_app/home.dart';
import 'login.dart';
import 'home.dart';
import 'map.dart';
import 'registration.dart';
import 'list.dart';
import 'rentierList.dart';
import 'mapStuff.dart';
import 'help.dart';

var themeYellow = Color(0xF9AA33).withOpacity(1);
var themeGrey = Colors.blueGrey[700];

class NexusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //loads custom map display pin
    setCustomMapPin();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Nexus',
      // defines theme that will be inherited by rest of application
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: themeGrey,
        accentColor: themeYellow,
        fontFamily: 'Rubik', 
        textTheme: TextTheme()
       
      ),
        //If logged in go to home, else go to login page. Currently j goes to login for testing purposes
        home: HomePage(),
        initialRoute: '/login',
        onGenerateRoute: _getRoute,
        routes: <String, WidgetBuilder>{
          '/map': (BuildContext context) { return MapPage();},
          '/registration': (BuildContext context) {return RegistrationPage();},
          '/list': (BuildContext context) {return ListPage();},
          '/addProp': (BuildContext context) {return AddPropertyPage();},
          '/addLand': (BuildContext context) {return AddLandlordPage();},
          '/rentierList': (BuildContext context) {return RentierListPage();},
          '/homePage': (BuildContext context) {return HomePage();},
          '/help': (BuildContext context) {return HelpPage();},

          //'/property': (BuildContext context) {return Property();},
        }
    );
  }

  //Dynamic route maker. If user not logged in, initial route stays '/login', and goes to login page.
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}