import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  String firstName, lastName, email, password;
  String testEmail = "", testPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: SafeArea(
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
                                  decoration:
                                  InputDecoration(labelText: 'First name'),
                                  validator: (input) =>
                                  !matches(input, r'^[A-Za-z]+$')
                                      ? 'Not a valid First name'
                                      : null,
                                  onSaved: (input) => firstName = input,
                                ),
                              ),
                              Expanded(
                                  child: TextFormField(
                                    decoration:
                                    InputDecoration(labelText: 'Last name'),
                                    validator: (input) =>
                                    !matches(input, r'^[A-Za-z]+$')
                                        ? 'Not a valid Last name'
                                        : null,
                                    onSaved: (input) => lastName = input,
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Email"),
                              validator: (input) {
                                if (!isEmail(input)) {
                                  return 'Not a valid email';
                                } else {
                                  testEmail = input;
                                  return null;
                                }
                              },
                              onSaved: (input) => email = input,
                            )),
                        Expanded(
                            child: TextFormField(
                              decoration:
                              InputDecoration(labelText: "Re-enter email"),
                              validator: (input) => input.compareTo(testEmail) != 0
                                  ? 'Email does not match'
                                  : null,
                            )),
                        Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Password"),
                              validator: (input) {
                                if (!matches(input,
                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")) {
                                  return 'Minimum 8 characters, at least 1 uppercase, lowercase and number';
                                } else {
                                  testPassword = input;
                                  return null;
                                }
                              },
                              onSaved: (input) => password = input,
                              obscureText: true,
                            )),
                        Expanded(
                            child: TextFormField(
                              decoration:
                              InputDecoration(labelText: "Re-enter password"),
                              validator: (input) =>
                              input.compareTo(testPassword) != 0
                                  ? 'Password does not match'
                                  : null,
                              obscureText: true,
                            )),
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
                                          onPressed: () {
                                            if (formKey.currentState.validate()) {
                                              formKey.currentState.save();

                                              print(email);
                                              print(password);
                                              print(firstName);
                                              //TODO: Link with RL DBS], if everything goes well show the bellow code (STARTS HERE to ENDS HERE) else dont

                                              //STARTS HERE
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Well Done!"),
                                                      content:
                                                      SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text(
                                                                "You successfully created an account")
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.popUntil(
                                                                context,
                                                                ModalRoute.withName(
                                                                    '/login'));
                                                          },
                                                          child: Text("Ok"),
                                                        )
                                                      ],
                                                    );
                                                  });
                                              //ENDS HERE
                                            }
                                          },
                                          child: Text('Create Account')),
                                    ))
                              ],
                            ))
                      ],
                    )))));
  }
}
