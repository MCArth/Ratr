import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'houseFunctions.dart';

List<HouseBasic> testHouse = [
  HouseBasic(),

];




//Hard coded marker locations/informaton for testing map functionality and navigation
final Set<Marker> _testMarkers = {
  //Near Uni 1
  Marker(
    markerId: MarkerId("NearUni1"),
    position: LatLng(51.377360, -2.333635),
    onTap: null,
     ),
  //Near Uni 2
  Marker(
    markerId: MarkerId("NearUni2"),
    position: LatLng(51.376007, -2.342781),
    onTap: null,
  ),
  //Oldfield Park 1
  Marker(
    markerId: MarkerId("OldfieldPark1") ,
    position: LatLng(51.377226, -2.384187),
    onTap: null,
  ),
  //Oldfield Park 2
  Marker(
    markerId: MarkerId("OldfieldPark2"),
    position: LatLng(51.377253, -2.383962),
    onTap: null,
  ),
  //Oldfield Park 3
  Marker(
    markerId: MarkerId("OldfieldPark3"),
    position: LatLng(51.376704, -2.381291),
    onTap: null,
  )
  };