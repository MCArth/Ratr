import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'functionsAndData.dart';
import 'prop.dart';

// LatLng bounds for Bath camera view
CameraTargetBounds bath = new CameraTargetBounds(
  LatLngBounds(
    northeast: LatLng(51.409029,-2.321211),
    southwest: LatLng(51.372760,-2.404860)));

//TODO marker todos must link to properties 

//This function creates a marker from a house entry
Marker getMarker(BuildContext context,House house){
  var markerID = MarkerId(house.latlng.toString());
  //Ref: https://medium.com/@rajesh.muthyala/flutter-with-google-maps-and-google-place-85ccee3f0371
  Marker out = new Marker(
      markerId: markerID,
      position: house.latlng,
      infoWindow: InfoWindow(
      ),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () => {
         Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Property(houseList.indexOf(house))),
         )
      }
    );
  return out;
  }

//Generates marker list from list of houses to be display in the map
Set<Marker> buildMapMarkers(BuildContext context){
  Set<Marker> out = {};
  for(var i = 0; i < houseList.length; i++){
    out.add(getMarker(context, houseList[i]));
  }
  return out;
}

