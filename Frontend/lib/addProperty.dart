import 'package:flutter/material.dart';

class addProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addProperty();
}

class _addProperty extends State<addProperty> {
  RangeValues _values = RangeValues(500.0, 750.0);
  int min = 500;
  int max = 750;

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
                    Header("Price per month:"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            child: Text(
                              "Minimum: $min £",
                            ),
                            padding: EdgeInsets.all(17.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: Text("Maximum: $max £"),
                            padding: EdgeInsets.all(17.0),
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      min: 500.0,
                      max: 3500.0,
                      values: _values,
                      divisions: 300,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          _values = newValues;
                          min = _values.start.toInt();
                          max = _values.end.toInt();
                        });
                      },
                    ),
                    Header("Address:"),
                    TextFormField(),
                    Header("Description:"),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 8,
                    ),
                    Header("Phone number of Landlord:"),
                    TextFormField()
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
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
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
