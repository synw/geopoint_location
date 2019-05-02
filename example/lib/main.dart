import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geopoint_location/geopoint_location.dart';

class _GeopointLocationPageState extends State<GeopointLocationPage> {
  GeoPoint locationPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Padding(padding: const EdgeInsets.only(top: 15.0)),
            RaisedButton(
                child: const Text("Get location point"),
                onPressed: () => geoPointFromPosition(
                            name: "Current position", withAddress: true)
                        .then((geoPoint) {
                      setState(() => locationPoint = geoPoint);
                    })),
            const Padding(padding: const EdgeInsets.only(top: 15.0)),
            (locationPoint != null)
                ? Column(
                    children: <Widget>[
                      Text("Latitude ${locationPoint.latitude}"),
                      Text("Longitude ${locationPoint.longitude}"),
                      Text("Altitude ${locationPoint.altitude}"),
                      Text("Speed ${locationPoint.speed}"),
                      Text("Address ${locationPoint.address}"),
                    ],
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}

class GeopointLocationPage extends StatefulWidget {
  @override
  _GeopointLocationPageState createState() => _GeopointLocationPageState();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geopoint location demo',
      home: GeopointLocationPage(),
    );
  }
}
