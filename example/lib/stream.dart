import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geopoint_location/geopoint_location.dart';

import 'position_widget.dart';

class _StreamPageState extends State<StreamPage> {
  _StreamPageState() : _loc = LocationStream();

  final LocationStream _loc;
  GeoPoint _geoPoint;
  StreamSubscription<GeoPoint> _sub;
  bool _ready = false;
  int _updateNum = 0;

  @override
  void initState() {
    super.initState();
    _loc.initGeoPointStream();
    _sub = _loc.geoPointStream.listen((pos) => setState(() {
          _ready = true;
          _geoPoint = pos;
          ++_updateNum;
          print(pos.details());
        }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Scaffold(
              body: SafeArea(
                  child: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Update $_updateNum", textScaleFactor: 2.0)),
        _ready
            ? PositionWidget(locationPoint: _geoPoint)
            : const CircularProgressIndicator()
      ]))));

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}
