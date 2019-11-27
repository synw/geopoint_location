import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geopoint_location/geopoint_location.dart';

import 'position_widget.dart';

class _SimplePageState extends State<SimplePage> {
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
                onPressed: () =>
                    geoPointFromLocation(verbose: true, withAddress: true)
                        .then((geoPoint) {
                      print("Geopoint: $geoPoint");
                      setState(() => locationPoint = geoPoint);
                    })),
            const Padding(padding: const EdgeInsets.only(top: 15.0)),
            (locationPoint != null)
                ? PositionWidget(locationPoint: locationPoint)
                : const Text("")
          ],
        ),
      ),
    );
  }
}

class SimplePage extends StatefulWidget {
  @override
  _SimplePageState createState() => _SimplePageState();
}
