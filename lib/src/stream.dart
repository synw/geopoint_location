import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geopoint/geopoint.dart';

import 'loc.dart';

class LocationStream {
  LocationStream();

  Stream<Position> _positionStream;
  Stream<GeoPoint> _geoPointStream;
  var _initializing = false;

  Stream<GeoPoint> get geoPointStream => _geoPointStream;

  /// Get a stream of [GeoPoint] locations
  void initGeoPointStream({int timeInterval = 3000, int distanceFilter}) {
    if (_positionStream == null) {
      _initPositionStream(timeInterval, distanceFilter);
    }
    final transformer = StreamTransformer<Position, GeoPoint>.fromHandlers(
        handleData: _geoPointTransform);
    _geoPointStream = _positionStream.transform(transformer);
  }

  void _geoPointTransform(Position pos, EventSink sink) =>
      sink.add(geoPointFromPositionSync(position: pos));

  void _initPositionStream(int timeInterval, int distanceFilter) {
    if (_initializing) {
      // prevent concurrent calls
      return;
    }
    _initializing = true;
    final geolocator = Geolocator();
    LocationOptions options;
    if (distanceFilter == null) {
      options = LocationOptions(
          accuracy: LocationAccuracy.best, timeInterval: timeInterval);
    } else {
      options = LocationOptions(
          accuracy: LocationAccuracy.best, distanceFilter: distanceFilter);
    }
    _positionStream = geolocator.getPositionStream(options).asBroadcastStream();
    _initializing = false;
  }
}
