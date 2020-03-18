import 'package:flutter/material.dart';
import 'package:nexus_app/review.dart';
import 'login.dart';
import 'home.dart';
import 'map.dart';
import 'registration.dart';
import 'prop.dart';
import 'list.dart';

class NexusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Nexus',
      //Build theme that will be inherited by rest of application
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[700],
        accentColor: Colors.blueGrey,
        fontFamily: 'Rubik',
        
      ),

      //If logged in go to home, else go to login page. Currently j goes to login for testing purposes
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: <String, WidgetBuilder>{
				'/map': (BuildContext context) { return MapPage();},
        '/registration': (BuildContext context) {return RegistrationPage();},
        '/list': (BuildContext context) {return ListPage();},
        //'/property': (BuildContext context) {return Property();},
			}
    );
  }

  //Dynamic route maker. If user not logged in, initial route stays '/login', and goes to login page. Else 
  //TODO integrate with back end
  //TODO if user is logged in (pending api call) go to home
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      //TODO go home
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}