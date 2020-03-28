import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'mapStuff.dart';




// TODO Create class that, on map creation, iterates through database and places markers at properties location. Markers should 
// link to property page
class MapPage extends StatefulWidget{ 
  @override
  _MapState createState() => _MapState();
}
 
class _MapState extends State<MapPage>{
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(51.382675, -2.366787);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = buildMapMarkers(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Bath Properties'),
        ),
        body: GoogleMap(
          cameraTargetBounds: bath,
          markers: markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 13.0,
          ),
          
    )
    );
  }
}