import 'package:flutter/foundation.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geolocator/geolocator.dart';
import 'package:slugify2/slugify.dart';

var _slugify = Slugify();

/// Returns a [GeoPoint] from the current position
/// taken from Geolocator
Future<GeoPoint> geoPointFromLocation(
    {bool withAddress = false,
    String name = "Current position",
    LocationAccuracy locationAccuracy = LocationAccuracy.best,
    bool verbose = false}) async {
  final position =
      await Geolocator().getCurrentPosition(desiredAccuracy: locationAccuracy);
  Placemark placemark;
  if (withAddress == true) {
    final placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    placemark = placemarks[0];
  }
  return _geoPointFromPosition(
      name: name, position: position, placemark: placemark, verbose: verbose);
}

/// Returns a [GeoPoint] from a given position
GeoPoint geoPointFromPositionSync(
    {@required Position position,
    String name = "Current position",
    LocationAccuracy locationAccuracy = LocationAccuracy.best,
    bool verbose = false}) {
  if (verbose) {
    print("Creating geopoint from position $position");
  }
  return _geoPointFromPosition(
      name: name, position: position, placemark: null, verbose: verbose);
}

/// Returns a [GeoPoint] from a given position
Future<GeoPoint> geoPointFromPosition(
    {@required Position position,
    String name,
    bool withAddress = false,
    LocationAccuracy locationAccuracy = LocationAccuracy.best,
    bool verbose = false}) async {
  if (verbose) {
    print("Creating geopoint from position $position");
  }
  Placemark placemark;
  if (withAddress == true) {
    final placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    placemark = placemarks[0];
  }
  return _geoPointFromPosition(
      name: name, position: position, placemark: placemark, verbose: verbose);
}

GeoPoint _geoPointFromPosition(
    {@required Position position,
    @required String name,
    @required Placemark placemark,
    @required bool verbose}) {
  GeoPoint geoPoint;
  String number;
  String street;
  String locality;
  String sublocality;
  String postalCode;
  //subregion = placemark.subAdministratieArea;
  String region;
  String country;

  final slug = _slugify.slugify(name);
  final timestamp = position.timestamp.millisecondsSinceEpoch;
  final latitude = position.latitude;
  final longitude = position.longitude;
  final altitude = position.altitude;
  final speed = position.speed;
  final accuracy = position.accuracy;
  final speedAccuracy = position.speedAccuracy;
  final heading = position.heading;
  if (placemark != null) {
    number = placemark.subThoroughfare;
    street = placemark.thoroughfare;
    locality = placemark.locality;
    sublocality = placemark.subLocality;
    postalCode = placemark.postalCode;
    //subregion = placemark.subAdministratieArea;
    region = placemark.administrativeArea;
    country = placemark.country;
  }
  geoPoint = GeoPoint(
      name: name,
      slug: slug,
      timestamp: timestamp,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      speed: speed,
      accuracy: accuracy,
      speedAccuracy: speedAccuracy,
      heading: heading,
      number: number,
      region: region,
      locality: locality,
      sublocality: sublocality,
      postalCode: postalCode,
      country: country,
      street: street);
  if (verbose) {
    print(geoPoint.toString());
  }
  return geoPoint;
}
