// @dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Geolocator geolocator = Geolocator();
  var currentPosition;
  var latitude;
  var longitude;

  getCurrentPosition() async {
    currentPosition = await _checkPermissions();
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
  }

  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Map"),
      ),
      drawer: const NavigationDrawerWidget(),
      body: FlutterMap(
        options: MapOptions(
            zoom: 16.0, center: LatLng(43.94640117857406, -78.89724695506891)),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/thinh188/ckwmh0iyb54fl15uow3jwdhpz/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidGhpbmgxODgiLCJhIjoiY2t3bWd2OHUwMmM2dDJvbnMyeGhidjc0eSJ9.ELj9YSYsIWVSfn5nyCbpSA",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoidGhpbmgxODgiLCJhIjoiY2t3bWd2OHUwMmM2dDJvbnMyeGhidjc0eSJ9.ELj9YSYsIWVSfn5nyCbpSA',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
        ],
      ),
    );
  }

  Future<Position> _checkPermissions() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
