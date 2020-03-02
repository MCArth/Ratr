<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(NexusApp());
=======
import 'package:flutter/material.dart';
import 'app.dart';


Future main() async {
  runApp(NexusApp());
  }

class HouseBasic{
  int lat;
  int long;
  int bedrooms;
  String address;

  HouseBasic(this.lat,this.long,this.address,this.bedrooms);
}
>>>>>>> samsbranch
