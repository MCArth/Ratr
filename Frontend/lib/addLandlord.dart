import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class addLandlord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addLandlord();
}

class _addLandlord extends State<addLandlord> {
  //todo change this to do backend stuff
  String name = "Landlord Review";
  String landlordReview = "";
  final formKey = GlobalKey<FormState>();
  double value = 5.0;
  var ratingIcon = Icons.account_circle;
  var iconColour = Colors.white;
  String landlord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Landlord"),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Landlord:",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Container(
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Yassin Ouzzane"),
                          validator: (input) =>
                          !matches(input, r'^[A-Z][a-z]+\s[A-Z][a-z]+$')
                              ? 'Not a valid Full Name'
                              : null,
                          onSaved: (input) => landlord = input,
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Please write your review below for '
                            'the landlord chosen:',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 18, color: Color(0xF9AA33).withOpacity(1)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Landlord Review:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                    width: 10.0, style: BorderStyle.solid)),
                            filled: true,
                            hintText: 'Write your review here...'),
                        validator: (input) => !matches(input, r'^[A-Za-z\n]+$')
                            ? 'Invalid description, needs to consist of letters'
                            : null,
                        onSaved: (input) => landlordReview = input,
                        //labelText: 'House Review')
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
//                          Align(
//                            alignment: Alignment.centerRight,
//                            child: RaisedButton(
//                                //color: Colors.orange,
//                                color: Colors.blue,
//                                disabledColor: Colors.pink,
//                                disabledTextColor: Colors.black,
//                                splashColor: Colors.lightGreen,
//                                child: Text(
//                                  'POST',
//                                  style: TextStyle(color: Colors.white),
//                                ),
//                                //todo stuff goes here
//                                onPressed: _submitLandlordReview),
//                          ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Landlord Rating:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    SizedBox(height: 16),
                    Row(children: <Widget>[
                      Expanded(
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 3.0,
                                thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                                //overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                valueIndicatorShape:
                                PaddleSliderValueIndicatorShape(),
                                valueIndicatorTextStyle: TextStyle(
                                  color: iconColour,
                                ),
                              ),
                              child: Slider(
//                                      inactiveColor: Colors.white,
                                activeColor: Colors.black,
                                label: '$value',
                                value: value,
                                min: 0.0,
                                max: 5.0,
                                divisions: 40,
                                onChanged: (newValue) {
                                  setState(() {
                                    value = newValue;
                                    if (value >= 7.0) {
                                      iconColour = Colors.green;
                                      return;
                                    }
                                    if (value >= 4.0) {
                                      iconColour = Colors.yellow;
                                    } else
                                      iconColour = Colors.red;
                                  });
                                },
                              ))),
//                            Expanded(
//                              child: Text('10'),
//                            ),
                    ]),
                    SizedBox(
                      height: 22,
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
                          onPressed: () {}),
                    )
                    //text to show slider value + colour
//                          Container(
//                            //child: Icon(ratingIcon, size: 50, color: iconColour,),
//                            child: Text(
//                              value.toString(),
//                              style: TextStyle(
//                                color: iconColour,
//                                fontSize: 28,
//                              ),
//                            ),
//                          )
                  ])
                ],
              ),
            ),
          )),
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
