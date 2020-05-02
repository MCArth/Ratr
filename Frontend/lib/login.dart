import 'package:flutter/material.dart';
import 'app.dart';
import 'registration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeGrey,
      body: SafeArea( 
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 60.0),
            Column(
              children: <Widget>[
                Image(image: AssetImage('assets/2x/logo@2x.png')),
                SizedBox(height: 2.0),
                Text('RENTAL NEXUS',style: TextStyle(fontFamily: 'Rubik',fontSize: 20.0)),
              ],
            ),
            SizedBox(height: 15.0),
            //Column(children: <Widget>[Text("Welcome back!",style: TextStyle(fontFamily: 'Rubik',color: Colors.white,fontSize: 20.0)),]),
            
            //Spacing from logo
            SizedBox(height: 10.0),

            //Username field
            Container(
              height: 36.0,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Username',  
                ),
              ),
            ),
            //Spacing
            SizedBox(height: 12.0),

            //Password field
            Container(
              height: 36.0,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonMinWidth: 100,
              children: <Widget>[
                  // FlatButton(
                  //   child: Text('CANCEL'),
                  //   onPressed: (){
                  //     _usernameController.clear();
                  //     _passwordController.clear();
                  //   }
                  // ),
                  RaisedButton(
    
                    color: Color(0xF9AA33).withOpacity(1),
                    child: Text('LOGIN'),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                
              ],
            ),
            SizedBox(height: 12.0),
            Center(
              child: new InkWell( 
                child: Text("Not registered yet? Click here!"),
                onTap:() {
                  Navigator.pushNamed(context,'/registration');
                  } //Go to registration page
                )
            )
          ],
        ),
      ),
    );
  }
}
