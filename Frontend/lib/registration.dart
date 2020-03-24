import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:developer';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  String firstName, lastName, email, password;
  String testemail = "", testpassword = "";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'First name'),
                            validator: (input) => !matches(input,r'^[A-Za-z]+$') ? 'Not a valid First name' : null,
                            onSaved: (input) => firstName = input,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Last name'),
                            validator: (input) => !matches(input,r'^[A-Za-z]+$') ? 'Not a valid Last name' : null,
                            onSaved: (input) => lastName = input,
                          )
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      validator: (input) {
                        if(!isEmail(input)) {
                          return 'Not a valid email';
                        } else{
                          testemail = input;
                          return null;
                        }
                      },
                      onSaved: (input) => email = input,
                    )
                  ),

                  Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Re-enter email"),
                        validator: (input) => input.compareTo(testemail) != 0 ? 'Email does not match' : null,
                      )
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                      validator: (input) {
                        if(!matches(input, r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")){
                          return 'Minimum 8 characters, at least 1 uppercase, 1 lowercase and 1 number';
                        } else{
                          testpassword = input;
                          return null;
                        }
                      },
                      onSaved: (input) => password = input,
                      obscureText: true,
                    )
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Re-enter password"),
                      validator: (input) => input.compareTo(testpassword) != 0 ? 'Password does not match' : null,
                      obscureText: true,
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 350,
                            height: 50,
                            child: RaisedButton(
                              onPressed: _submit,
                              child: Text('Create Account')),
                          )
                        )
                      ],
                    )
                  )



                ],
              )
            )
        )
      )

    )
    );
  }

  void _submit() {
    log("yo bitch");
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      log(email);
      log(password);
      log(firstName);
      //Popup saying that account was created successfully
      //Link with RL DBS
      //Go back to home bage
    }
  }
  
}