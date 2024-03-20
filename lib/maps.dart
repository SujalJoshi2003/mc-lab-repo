import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<Maps> {
  MapController _mapController = MapController();
  List<Marker> _markers = [];

  void _searchLocation(String query) async {
    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data != null && data.isNotEmpty) {
        final location = data[0];
        final latitude = double.parse(location['lat']);
        final longitude = double.parse(location['lon']);

        _markers.clear();


        _markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(latitude, longitude),
            child: Icon(Icons.location_on, color: Colors.green, size: 50),

          ),
        );


        _mapController.move(LatLng(latitude, longitude), 10.0);
      } else {
        // Handle no results found
      }
    } else {
      // Handle API call failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(19.0728, 72.8999),
                zoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
                CurrentLocationLayer(
                  followOnLocationUpdate: FollowOnLocationUpdate.always,
                  turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation,
                        color: Colors.white,
                      ),
                    ),
                    markerSize: const Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              ],

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a location',
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: _searchLocation,
            ),
          ),
    ],
    ),
    );
  }
}