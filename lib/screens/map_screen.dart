import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class MapScreen extends StatelessWidget {
  static const routeName = '/map';

  Map<dynamic, dynamic> location;
  String patientName;

  MapScreen(this.location, this.patientName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location of $patientName'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(location['lat'], location['lng']),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: LatLng(location['lat'], location['lng']),
                builder: (ctx) => Container(
                  child: Icon(Icons.pin_drop),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
