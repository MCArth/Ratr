import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'addAndModify.dart';
import 'functionsAndData.dart';
import 'app.dart';


//Page allowing user creation of new property entries
class AddPropertyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddProperty();
}

class AddProperty extends State<AddPropertyPage> {
  final formKey = GlobalKey<FormState>();
  double price = 500.0;
  String address, postcode, description, landlord, phoneNumber;
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
                        activeColor: themeYellow,
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
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                        child: Text(
                      "Address:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    Container(
                        child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText:
                              "e.g. 2 Beckhampton Road"),
                      validator: (input) =>
                          !matches(input, r'^[#.0-9a-zA-Z\s,-]+$')
                              ? 'Not a valid Address'
                              : null,
                      onSaved: (input) => address = input.replaceAll("\t",""),
                    )
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                      "Postcode:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    Container(
                        child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText:
                              "e.g. BA2 3LL"),
                      validator: (input) =>
                          !matches(input, r'^[#.0-9a-zA-Z\s,-]+$')
                              ? 'Not a valid postcode'
                              : null,
                      onSaved: (input) => postcode = input.replaceAll("\t",""),
                    )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Text(
                      "Description:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 4,
//                        decoration: InputDecoration(
//                            hintText: "Insert description of property"
//                        ),
                        validator: (input) =>
                            !matches(input, r'^[#.0-9a-zA-Z\s,-]+$')
                                ? 'Not a valid Description'
                                : null,
                        onSaved: (input) => description = input,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Number of Bedrooms:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            //Header("Number of Bedrooms:"),
                            SizedBox(
                              height: 90,
                              child: NumberPicker.integer(
                                  infiniteLoop: true,
                                  initialValue: nBedrooms,
                                  minValue: 1,
                                  maxValue: 15,
                                  onChanged: (newValue) =>
                                      setState(() => nBedrooms = newValue)),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Text(
                              'Number of Bathrooms:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 90,
                              child: NumberPicker.integer(
                                  infiniteLoop: true,
                                  initialValue: nBathrooms,
                                  minValue: 1,
                                  maxValue: 15,
                                  onChanged: (newValue) =>
                                      setState(() => nBathrooms = newValue)),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        child: Text(
                      "Landlord:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: RaisedButton(
                            color: themeYellow,
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                double lat;
                                double long;
                                String street;
                                int houseNum;
                                await getFromAddress(address).then((latlng) {
                                  (lat = latlng.latitude);
                                  (long = latlng.longitude);
                                }, onError: (error) {
                                  print(error);
                                });
                                var splitStreet = address.split(" ");
                                street = parseStreet(address);

                                houseNum = (double.parse(splitStreet[0])).toInt();
                                if(landlord == null){landlord = "unknown";
                                }
                                //Create house object here based on user inputs
                                //feed into houseToDatabase which pushes to database
                                House newHouse = new House(
                                  lat: lat,
                                  long:long,
                                  avgRating: 0,
                                  houseNum: houseNum,
                                  street: street,
                                  postCode: postcode,
                                  landlord: landlord,
                                  price: price.toInt(),
                                  bedrooms: nBedrooms,
                                  bathrooms: nBathrooms,
                                  );
                                propertyToDatabase(newHouse);
                                
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () => Future.value(false),
                                        child: AlertDialog(
                                          title: Text("Well Done!"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    "You successfully created a property profile 🎉🎉")
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).popUntil(
                                                    ModalRoute.withName(
                                                        Navigator
                                                            .defaultRouteName));
                                              },
                                              child: Text("Ok"),
                                            )
                                          ],
                                        ),
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

String parseStreet(String address){
  var split = address.split(" ");
  String out = "";
  for(var i = 0; i < split.length - 1; i++){
    out += (split[i + 1] + " ");
  }
  return out;
}
