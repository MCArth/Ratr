import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class addProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addProperty();
}

class _addProperty extends State<addProperty> {
  double value = 500.0;
  int printValue = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Property"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
                child: ListView(
                  children: <Widget>[
                    Container(
                        child: Header("Price per month:")
                    ),
                    Container(
                      child: Text("Selected: $printValue £"),
                    ),
                    Container(
                      child: Slider(
                        min: 500.0,
                        max: 3500.0,
                        value: value,
                        divisions: 300,
                        onChanged: (double newValue) {
                          setState(() {
                            value = newValue;
                            printValue = value.toInt();
                          });
                        },
                      ),
                    ),
                    Container(child: Header("Address:")),
                    Container(child: TextFormField()),
                    Container(child: Header("Description:")),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 8,
                      ),
                    ),
                    Container(child: Header("Phone number of Landlord:")),
                    Container(child: TextFormField()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () => print("hellooo"),
                              child: Text('Create Account')),
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
