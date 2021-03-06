import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'functionsAndData.dart';
import 'prop.dart';

BitmapDescriptor pinIcon;
// LatLng bounds for Bath camera view
CameraTargetBounds bath = new CameraTargetBounds(
  LatLngBounds(
    northeast: LatLng(51.409029,-2.321211),
    southwest: LatLng(51.372760,-2.404860)));


//creates a marker from a house entry
Marker getMarker(BuildContext context,House house){
  var markerID = MarkerId(house.latlng.toString());
  Marker out = new Marker(
      markerId: markerID,
      position: house.latlng,
      infoWindow: InfoWindow(
      ),
      icon: pinIcon,
      onTap: () => {
         Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Property(house.latlng)),
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

void setCustomMapPin() async {
      pinIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 4),
      'assets/1x/pin.png');
   }