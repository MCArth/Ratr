import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget{
  final formKey = GlobalKey<FormState>();
  String firstName, lastName, email, password;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Card(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      TextFormField(
                        decoration: InputDecoration(labelText: 'First name'),
                        validator: (input) => !input.contains('A-Za-z') ? 'Not a valid First name' : null,
                        onSaved: (input) => firstName = input,
                      ),

                      TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        validator: (input) => !input.contains('A-Za-z') ? 'Not a valid Last name' : null,
                        onSaved: (input) => lastName = input,
                      )

                    ],
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (input) => input.contains('@') ? 'Not a valid email' : null,
                    onSaved: (input) => email = input,
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Re-enter email"),
                    validator: (input) => input.compareTo(email) != 0 ? 'Email does not match' : null,
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    validator: (input) => input.length < 8 ? 'Must be greater than 8' : null,
                    onSaved: (input) => password = input,
                    obscureText: true,
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Re-enter password"),
                    validator: (input) => input.compareTo(password) != 0 ? 'Password does not match' : null,
                    obscureText: true,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            onPressed: _submit,
                            child: Text('Sign in')),
                      )
                    ],
                  )


                ],
              )
            )
        )
      )

    );
  }

  void _submit() {
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      //Popup saying that account was created successfully
      //Link with RL DBS
      //Go back to home bage
    }
  }
  
}