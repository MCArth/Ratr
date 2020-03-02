import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

final Set<Marker> _markers = {};

class MapPage extends StatefulWidget{ 
  @override
  _MapState createState() => _MapState();
}
 
class _MapState extends State<MapPage>{
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(51.3782, -2.3264);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

// TODO Create class that, on map creation, iterates through database and places markers at properties location. Markers should 
// link to property page

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
      onPressed: () {
        getMarker();
      },
      child: Icon(Icons.navigation),
      backgroundColor: Colors.blue,
    ),
    );
  }
}

