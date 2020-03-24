import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

final Set<Marker> _markers = {};

final Set<Marker> markers = {};

//TODO marker todos must link to properties 
// final Set<Marker> _testMarkers = {
//   //Near Uni 1
//   Marker(
//     markerId: MarkerId("NearUni1"),
//     position: LatLng(51.377360, -2.333635),
//     onTap: null,
//      ),
//   //Near Uni 2
//   Marker(
//     markerId: MarkerId("NearUni2"),
//     position: LatLng(51.376007, -2.342781),
//     onTap: null,
//   ),
//   //Oldfield Park 1
//   Marker(
//     markerId: MarkerId("OldfieldPark1") ,
//     position: LatLng(51.377226, -2.384187),
//     onTap: null,
//   ),
//   //Oldfield Park 2
//   Marker(
//     markerId: MarkerId("OldfieldPark2"),
//     position: LatLng(51.377253, -2.383962),
//     onTap: null,
//   ),
//   //Oldfield Park 3
//   Marker(
//     markerId: MarkerId("OldfieldPark3"),
//     position: LatLng(51.376704, -2.381291),
//     onTap: null,
//   )
//   };

class MapPage extends StatefulWidget{ 
  @override
  _MapState createState() => _MapState();
}
 
class _MapState extends State<MapPage>{
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  static const LatLng _center = const LatLng(51.3782, -2.3264);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Bath Properties'),
        ),
        body: GoogleMap(
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.navigation),
      backgroundColor: Colors.blue,
    ),
    );
  }

// TODO Create class that, on map creation, iterates through database and places markers at properties location. Markers should 
// link to property page


//function building list of markers from list of landlords

//This function creates a marker from a single entry
void getMarker(){
  var markerID = MarkerId("Test Marker");
  var pos = LatLng(51.3782, -2.3264);
  //Ref: https://medium.com/@rajesh.muthyala/flutter-with-google-maps-and-google-place-85ccee3f0371
  setState(() {
      _markers.add(
        Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: markerID,
      position: pos,
      infoWindow: InfoWindow(
      ),
      icon: BitmapDescriptor.defaultMarker,
    )
  );
  }
  );
}



}