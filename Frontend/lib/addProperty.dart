import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class addProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addProperty();
}

class _addProperty extends State<addProperty> {
  final formKey = GlobalKey<FormState>();
  double price = 500.0;
  String address, description, phoneNumber;

  //Tracks the value of price and puts it into a int variable for printing
  int printPrice= 500;

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
              key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        child: Header("Price per month:")
                    ),
                    Container(
                      child: Text("Selected: $printPrice £"),
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
                    Container(child: Header("Address:")),
                    Container(child: TextFormField(
                      validator: (input) => !matches(input,r'^[#.0-9a-zA-Z\s,-]+$') ? 'Not a valid Address' : null,
                      onSaved: (input) => address = input,
                    )),
                    Container(child: Header("Description:")),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 8,
                        validator: (input) => !matches(input,r'^[#.0-9a-zA-Z\s,-]+$') ? 'Not a valid Description' : null,
                        onSaved: (input) => description = input,
                      ),
                    ),
                    Container(child: Header("Phone number of Landlord:")),
                    Container(child: TextFormField(
                      //Accepts:
                      //
                      //+(01) 123 (456) 789 ext555
                      //123456
                      //*44 123-456-789 [321]
                      //123456
                      //123456789012345678901234567890123456789012345
                      //*****++[](][((( 123456tteexxttppww
                      //Rejects:
                      //
                      //mob 07777 777777
                      //1234 567 890 after 5pm
                      //john smith
                      //(empty)
                      //1234567890123456789012345678901234567890123456
                      //911
                      validator: (input) => !matches(input,r'^[+#*\(\)\[\]]*([0-9][ ext+-pw#*\(\)\[\]]*){6,45}$') ? 'Not a valid Phone Number' : null,
                      onSaved: (input) => phoneNumber = input,
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: RaisedButton(
                              onPressed: () {
                                if(formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  print(address);
                                  print(description);
                                  print(phoneNumber);
                                  print(price);
                                  //Popup saying that account was created successfully
                                  //Link with RL DBS
                                  //Go back to home bage
                                }
                              },
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
