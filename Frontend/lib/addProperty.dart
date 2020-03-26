import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:numberpicker/numberpicker.dart';

class addProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addProperty();
}

class _addProperty extends State<addProperty> {
  final formKey = GlobalKey<FormState>();
  double price = 500.0;
  String address, description, landlord, phoneNumber;
  int nBedrooms = 1;
  int nBathrooms = 1;

  //Tracks the value of price and puts it into a int variable for printing
  int printPrice = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Property"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(child: Header("Price per month:")),
                    Container(
                      child: Text("Selected:   £$printPrice"),
                    ),
                    Container(
                      child: Slider(
                        min: 500.0,
                        max: 3500.0,
                        value: price,
                        divisions: 300,
                        onChanged: (double newValue) {
                          setState(() {
                            price = newValue;
                            printPrice = price.toInt();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 14,),
                    Container(child: Text("Address:", style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                    Container(
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "2 Beckhampton road, Bath \nSomerset, England, BA2 3LL"
                          ),
                          validator: (input) =>
                          !matches(input, r'^[#.0-9a-zA-Z\s,-]+$')
                              ? 'Not a valid Address'
                              : null,
                          onSaved: (input) => address = input,
                        )),
                    SizedBox(height: 20,),
                    Container(child: Text("Description:", style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Insert description of property"
                        ),
                        validator: (input) =>
                        !matches(input, r'^[#.0-9a-zA-Z\s,-]+$')
                            ? 'Not a valid Description'
                            : null,
                        onSaved: (input) => description = input,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Number of Bedrooms:',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            //Header("Number of Bedrooms:"),
                            SizedBox(
                              height: 90,
                              child: NumberPicker.integer(infiniteLoop: true, initialValue: nBedrooms, minValue: 1, maxValue: 15, onChanged: (newValue) =>
                                  setState(() => nBedrooms = newValue)),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Text('Number of Bathrooms:',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 90,
                              child: NumberPicker.integer(infiniteLoop: true, initialValue: nBathrooms, minValue: 1, maxValue: 15, onChanged: (newValue) =>
                                  setState(() => nBathrooms = newValue)),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Container(child: Text("Landlord:", style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                    Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Yassin Ouzzane"
                          ),
                          validator: (input) => !matches(input, r'^[A-Z][a-z]+\s[A-Z][a-z]+$') ? 'Not a valid Full Name' : null,
                          onSaved: (input) => landlord = input,
                        )),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                                print(address);
                                print(description);
                                print(landlord);
                                print(phoneNumber);
                                print(price);
                                print(nBathrooms);
                                print(nBedrooms);
                                //TODO: Link with RL DBS], if everything goes well show the bellow code (STARTS HERE to ENDS HERE) else dont

                                //STARTS HERE
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Well Done!"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                  "You successfully created an property profile 🎉🎉")
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              /***
                                               * ERROR HERREEEEE
                                               * error:: Failed assertion: line 2330 pos 12: '!_debugLocked': is not true.
                                               * The error happens when you complete the form correctly
                                               * It works fine with registration.dart where i am popping until i reach the login screen but not here
                                               *
                                               * All i want to do is go back to the home page after they successfully added a property
                                               */
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      '/homePage'));
                                            },
                                            child: Text("Ok"),
                                          )
                                        ],
                                      );
                                    });
                                //ENDS HERE
                              }
                            },
                            child: Text('Add Property')),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            header,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          )),
    );
  }

  Header(String header) {
    this.header = header;
  }
}
