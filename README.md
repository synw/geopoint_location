# Geopoint location

[![pub package](https://img.shields.io/pub/v/geopoint_location.svg)](https://pub.dartlang.org/packages/geopoint_location)

Get [Geopoint](https://github.com/synw/geopoint) data from Geolocator [Position](https://pub.dev/documentation/geolocator/latest/geolocator/Position-class.html) updates

## Simple position

   ```dart
   import 'package:geopoint/geopoint.dart';
   import 'package:geopoint_location/geopoint_location.dart';

   GeoPoint geoPoint = await geoPointFromLocation(
      name: "Current position", withAddress: true);
   ```

## Positions stream

   ```dart
   import 'package:geopoint/geopoint.dart';
   import 'package:geopoint_location/geopoint_location.dart';

   StreamSubscription<GeoPoint> _sub;
   final _loc = LocationStream().initGeoPointStream();
   _sub = _loc.geoPointStream.listen((pos) => print("Position update $pos"));
   //_sub.cancel();
   ```

## Convert a geolocator Position to a GeoPoint

   ```dart
   import 'package:geopoint/geopoint.dart';
   import 'package:geopoint_location/geopoint_location.dart';

   final position = await Geolocator().getCurrentPosition();
   final GeoPoint geoPoint = await geoPointFromPosition(
      position: position,
      name: "Current position");
   ```

Same but sync, address not available:

   ```dart
   final GeoPoint geoPoint = geoPointFromPositionSync(
      position: position,
      name: "Current position");
   ```
