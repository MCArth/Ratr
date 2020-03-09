import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

void main() => runApp(ReviewWriter());

class ReviewWriter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Page',
      home: ReviewPage(),
    );
  }
}

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //todo get from backend stuff
    String propertyName = "Property Name";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          propertyName,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Please write your review below for '
                  'the property chosen:',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Property Review:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                                width: 10.0, style: BorderStyle.solid)),
                        filled: true,
                        hintText: 'Write your review here...')
                    //labelText: 'House Review')
                    ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.orange,
                  disabledColor: Colors.pink,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blue,
                  child: Text(
                    'POST',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Landlord Review:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                                width: 10.0, style: BorderStyle.solid)),
                        filled: true,
                        hintText: 'Write your review here...')
                    //labelText: 'House Review')
                    ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                    padding: EdgeInsets.all(5.0),
                    color: Colors.orange,
                    disabledColor: Colors.pink,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blue,
                    child: Text(
                      'POST',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {}),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload Images:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.image,
                              color: Colors.orange,
                              size: 55.0,
                            ))),
                    Center(
                        child: Container(
                            height: 80,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
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
                          color: Colors.orange,
                          disabledColor: Colors.pink,
                          disabledTextColor: Colors.black,
                          splashColor: Colors.blue,
                          child: Text(
                            'POST',
                            style: TextStyle(color: Colors.white),
                          ),
                          //todo stuff goes here
                          onPressed: () {}),
                    )
                  ])
            ])
          ],
        ),
      ),
    );
  }
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
        toolbarTitle: 'Crop It'
    );

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