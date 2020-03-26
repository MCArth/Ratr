import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  String name = "Landlord Review";
  String landlordReview = "";
  final formKey = GlobalKey<FormState>();
  double value = 5.0;
  var ratingIcon = Icons.account_circle;
  var iconColour = Colors.white;

  //RangeValues values = RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
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
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Landlord Rating:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 15.0),
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
                                      max: 10.0,
                                      divisions: 20,
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
                                //todo Update backend here!!
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
