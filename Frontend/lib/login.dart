import 'package:flutter/material.dart';
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
      body: SafeArea( 
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Icon(
                    Icons.home,
                    color: Colors.grey,
                    size: 24.0,
                    semanticLabel: 'Placeholder App Logo',
                ),
                SizedBox(height: 16.0),
                Text('Rental Nexus'),
              ],
            ),

            //Spacing from top of screen
            SizedBox(height: 120.0),

            //Username field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            
            //Spacing
            SizedBox(height: 12.0),

            //Password field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: (){
                      _usernameController.clear();
                      _passwordController.clear();
                    }
                  ),
                  RaisedButton(
                    child: Text('LOGIN'),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                
              ],
            ),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)
            Center(
              child: new InkWell( 
                child: Text("Not registered yet? Click here!"),
                onTap:() {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                    builder: (ctxt) => new RegistrationPage()),
                  );
                  } //Go to registration page
                )
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)