// @dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Geolocator geolocator = Geolocator();
  final MapController mapController = MapController();
  final center = LatLng(43.94579, -78.89691);
  var currentPosition;
  LatLng currentLocation = LatLng(43.94579, -78.89691);
  List<LatLng> locations = [];

  getCurrentPosition() async {
    currentPosition = await checkPermissions();
    currentLocation =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    checkPermissions();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Map"),
        backgroundColor: Colors.purple,
      ),
      drawer: const NavigationDrawerWidget(),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          zoom: 16.0,
          center: center,
        ),
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
          MarkerLayerOptions(
              markers: [
                    Marker(
                        point: center,
                        builder: (BuildContext context) {
                          return IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return bottomSheet();
                                  });
                            },
                            icon: const Icon(Icons.location_on),
                            iconSize: 30.0,
                            color: Colors.purple,
                          );
                        }),
                  ] +
                  [
                    for (var i = 0; i < locations.length; i++)
                      Marker(
                          point: locations[i],
                          builder: (BuildContext context) {
                            return IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.circle),
                              iconSize: 20.0,
                              color: Colors.purple,
                            );
                          })
                  ]),
          PolylineLayerOptions(
            polylines: [
              if (locations.isNotEmpty)
                Polyline(
                  color: Colors.purple,
                  strokeWidth: 2.0,
                  points: [
                    center,
                    locations[0],
                  ],
                )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(
            () {
              getCurrentPosition();
              mapController.move(currentLocation, 13);
              if (locations.isNotEmpty) {
                locations.removeLast();
              }
              if (currentLocation != center) {
                locations.add(currentLocation);
              }
            },
          );
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }

  Future<Position> checkPermissions() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Widget bottomSheet() {
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.purple,
          child: const ListTile(
            title: Text(
              "Ontario Tech University",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            subtitle: Text(
              "2000 Simcoe St N, Oshawa, ON L1G 0C5",
              style: TextStyle(color: Colors.white70, fontSize: 14.0),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              const ListTile(
                title: Text("Open 7:00 - 15:00 (Mon - Fri)"),
                leading: Icon(
                  Icons.timer,
                  color: Colors.purple,
                ),
              ),
              ListTile(
                title: const Text("(905) 721-8668"),
                leading: const Icon(
                  Icons.phone,
                  color: Colors.purple,
                ),
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: "(905) 721-8668"));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Copied"),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("https://ontariotechu.ca/"),
                leading: const Icon(
                  Icons.language,
                  color: Colors.purple,
                ),
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: "https://ontariotechu.ca/"));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
