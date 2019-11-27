import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget({
    Key key,
    @required this.locationPoint,
  }) : super(key: key);

  final GeoPoint locationPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Latitude ${locationPoint.latitude}"),
        Text("Longitude ${locationPoint.longitude}"),
        Text("Altitude ${locationPoint.altitude}"),
        Text("Speed ${locationPoint.speed}"),
        Text("Address ${locationPoint.address}"),
      ],
    );
  }
}
