import 'dart:io';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:developer';

//void main() => runApp(ReviewPage());
//No need for main here, can be accessed from app

//Global variables to do db stuff
int landLat;
int landLong;

class LandlordReview extends StatefulWidget {

  @override
  _LandlordReview createState() => _LandlordReview();
}

class _LandlordReview extends State<LandlordReview> {
  //todo change this to do backend stuff
  String name = "Landlord Review";
  String landlordReview = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //todo get from backend stuff

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Card(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Please write your review below for '
                                  'the landlord chosen:',
                              textDirection: TextDirection.ltr,
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Landlord Review:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                          ),
//                          Container(
//                            padding: EdgeInsets.symmetric(vertical: 10),
//                            child: TextFormField(
//                              keyboardType: TextInputType.multiline,
//                              minLines: 7,
//                              maxLines: 7,
//                              decoration: InputDecoration(
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(3.0),
//                                      borderSide: BorderSide(
//                                          width: 10.0,
//                                          style: BorderStyle.solid)),
//                                  filled: true,
//                                  hintText: 'Write your review here...'),
//                              validator: (input) => !matches(
//                                  input, r'^[A-Za-z\n]+$')
//                                  ? 'Invalid description, needs to consist of letters'
//                                  : null,
//                              onSaved: (input) => propertyReview = input,
//                              //labelText: 'House Review')
//                            ),
//                          ),
//                          Align(
//                            alignment: Alignment.centerRight,
//                            child: RaisedButton(
//                                color: Colors.blue,
//                                //disabledColor: Colors.pink,
//                                disabledTextColor: Colors.black,
//                                splashColor: Colors.lightGreen,
//                                child: Text(
//                                  'POST',
//                                  style: TextStyle(color: Colors.white),
//                                ),
//                                //todo stuff goes here
//                                onPressed: _submitPropertyReview),
//                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 7,
                              maxLines: 7,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                          width: 10.0,
                                          style: BorderStyle.solid)),
                                  filled: true,
                                  hintText: 'Write your review here...'),
                              validator: (input) => !matches(
                                  input, r'^[A-Za-z\n]+$')
                                  ? 'Invalid description, needs to consist of letters'
                                  : null,
                              onSaved: (input) => landlordReview = input,
                              //labelText: 'House Review')
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              //color: Colors.orange,
                                color: Colors.blue,
                                disabledColor: Colors.pink,
                                disabledTextColor: Colors.black,
                                splashColor: Colors.lightGreen,
                                child: Text(
                                  'POST',
                                  style: TextStyle(color: Colors.white),
                                ),
                                //todo stuff goes here
                                onPressed: _submitLandlordReview),
                          ),
                        ])
                      ],
                    )))),
      ),
    );
  }

  void _submitLandlordReview() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      log(landlordReview);
      //Popup saying that account was created successfully
      //Link with RL DBS
      //Go back to home bage
    }
  }

  void _submitImage() {}
}
