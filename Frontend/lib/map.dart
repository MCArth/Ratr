<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Properties in your area'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
    ),
    );
  }
=======
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold();
  }
  
>>>>>>> YassinIsCool
}