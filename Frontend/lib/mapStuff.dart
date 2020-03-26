import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'functionsAndData.dart';



//TODO marker todos must link to properties 

//This function creates a marker from a house entry
Marker getMarker(House house){
  var markerID = MarkerId(house.houseNum.toString() + house.street);
  var pos = LatLng(51.3782, -2.3264);
  //Ref: https://medium.com/@rajesh.muthyala/flutter-with-google-maps-and-google-place-85ccee3f0371
  Marker out = new Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: markerID,
      position: pos,
      infoWindow: InfoWindow(
      ),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () => null,
    );
  return out;
  }

Set<Marker> buildMapMarkers(){
  Set<Marker> out = {};
  for(var i = 0; i < houseList.length; i++){
    out.add(getMarker(houseList[i]));
  }
  return out;
}
