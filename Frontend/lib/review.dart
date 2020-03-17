import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:string_validator/string_validator.dart';
import 'package:path/path.dart' as Path;
import 'dart:developer';

//void main() => runApp(ReviewPage());
//No need for main here, can be accessed from app

int revLat;
int revLong;

class ReviewPage extends StatefulWidget {

  ReviewPage(int lat, int long) {
    revLat = lat;
    revLong = long;
    print(revLat);
  }

  @override
  _ReviewPage createState() => _ReviewPage();
}

class _ReviewPage extends State<ReviewPage> {
  //todo change this to do backend stuff
  String propertyName = "Latitude: "+revLat.toString();
  String propertyReview = "";
  String landlordReview = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //todo get from backend stuff

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
                              'Please write your review below for '
                                  'the property chosen:',
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
                              minLines: 4,
                              maxLines: 4,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: Colors.blue,
                              //disabledColor: Colors.pink,
                                disabledTextColor: Colors.black,
                                splashColor: Colors.blue,
                                child: Text(
                                  'POST',
                                  style: TextStyle(color: Colors.white),
                                ),
                                //todo stuff goes here
                                onPressed: _submitPropertyReview),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
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
                              minLines: 4,
                              maxLines: 4,
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
                                splashColor: Colors.blue,
                                child: Text(
                                  'POST',
                                  style: TextStyle(color: Colors.white),
                                ),
                                //todo stuff goes here
                                onPressed: _submitLandlordReview),
                          ),
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
                                          child: Icon(Icons.add, size: 40),
                                          backgroundColor: Colors.black,
                                          onPressed: chooseImage,
                                          materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                        ))),
                                //SizedBox(width: 70.0),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    //color: Colors.orange,
                                      color: Colors.blue,
                                      disabledColor: Colors.pink,
                                      disabledTextColor: Colors.black,
                                      splashColor: Colors.blue,
                                      child: Text(
                                        'POST',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      //todo stuff goes here
                                      onPressed: _submitImage),
                                )
                              ])
                        ])
                      ],
                    )))),
      ),
    );
  }

  void _submitPropertyReview() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      log(propertyReview);
      //Popup saying that account was created successfully
      //todo Link with RL DBS
      //Go back to home bage
    }
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