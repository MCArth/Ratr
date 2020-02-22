import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';

class NexusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Nexus',
      //If logged in go to home, else go to login page. Currently j goes to login for testing purposes
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );

  }

  //Dynamic route maker. If user not logged in, initial route stays '/login', and goes to login page. Else 
  //TODO integrate with back end
  //TODO if user is logged in (pending api calll) go to home
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