import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:nexus_app/app.dart';
import 'package:nexus_app/functionsAndData.dart';
import 'package:nexus_app/prop.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:developer';

//Global variables to do db stuff
House house;
var cord;

class ReviewPage extends StatefulWidget {

  ReviewPage(LatLng latLng) {
    house = getHouseFromLatLng(latLng);
    cord = latLng;
  }

  @override
  _ReviewPage createState() => _ReviewPage();
}

class _ReviewPage extends State<ReviewPage> {
  //String propertyName = "Latitude: "+revLat.toString();
  String propertyName = "Property Review";
  String propertyReview = "";
  String landlordReview = "";
  final formKey = GlobalKey<FormState>();
  var ratingIcon = Icons.account_circle;
  var iconColour = Colors.white;
  double value = 2.5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          propertyName,
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
                              'Tell us about your experience with this property:',
                              textDirection: TextDirection.ltr,
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Property Review:',
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
                              onSaved: (input) => propertyReview = input,
                              //labelText: 'House Review')
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Property Rating:',
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
                                      activeColor: themeGrey,
                                      label: '$value',
                                      value: value,
                                      min: 0.0,
                                      max: 5.0,
                                      divisions: 40,
                                      onChanged: (newValue) {
                                        setState(() {
                                          value = newValue;
                                          if (value >= 3.8) {
                                            iconColour = Colors.green;
                                            return;
                                          }
                                          if (value > 2.5) {
                                            iconColour = Colors.yellow;
                                          } else
                                            iconColour = Colors.red;
                                        });
                                      },
                                    ))),
                          ]),
                          SizedBox(height: 15,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Upload Images:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 20.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.image,
                                          //color: Colors.orange,
                                          size: 55.0,
                                        ))),
                                Center(
                                    child: Container(
                                        height: 80,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        alignment: Alignment.centerRight,
                                        child: FloatingActionButton(
                                          child: Icon(Icons.add, size: 40, color: Colors.white,),
                                          backgroundColor: themeYellow,
                                          //todo IMAGE SELECTION GOES HERE
                                          onPressed: () {chooseImage();},
                                          materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                        ))),
                                //SizedBox(width: 70.0),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    //color: Colors.orange,
                                      color: themeYellow,
                                      disabledColor: Colors.pink,
                                      disabledTextColor: Colors.black,
                                      splashColor: Colors.lightGreen,
                                      child: Text(
                                        'POST',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      //todo UPLOAD IMAGE TO DB
                                      onPressed: () {
                                        //_submitImage();
                                        _submitPropertyReview();
                                      }
                                )
                                )
                              ]
                              )
                        ]
                        )
                      ],
                    )))),
      ),
    );
  }

  void _submitPropertyReview() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      log(propertyReview);
      double total = 0;
      //todo backend stuff goes here
      var revs = house.reviews;
      for (var a in revs) {
        print(a.review);
        total += a.rating;
      }
      var newAvg = total/revs.length;
      print("New avg: "+newAvg.toString());
      print("New rev: " + propertyReview);
      print("New rating: " + value.toString());

      addNewReview(cord, propertyReview, value,newAvg);

      //end of backend stuff

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title:Text("Thanks!"),
              content: Text("We've received your review!"),
              actions: <Widget>[
                new FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context)..popUntil((route) => route.isFirst);
                  },
                ),
              ],
            );
          }
      );
    }
  }

  void _submitImage() {}
}

//The code below doesn't really work, will leave here for - plz fix lol

class _ImageUpload extends State<Image> {
  File _image;

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      _image = cropped ?? _image;
    });
  }
  //TODO Catch PlatformException(photo_access_denied, The user did not allow photo access.,)
  //TODO catch error on going back from image picker
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => chooseImage(),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_image != null) ...[
            Image.file(_image),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}

File chooseImage() {
  var load = new _ImageUpload();
  load.chooseFile();

  return load._image;
}