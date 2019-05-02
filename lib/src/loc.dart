import 'package:flutter/foundation.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geolocator/geolocator.dart';
import 'package:slugify2/slugify.dart';

var _slugify = Slugify();

/// Returns a [GeoPoint] from a position of given of from
/// the current position
Future<GeoPoint> geoPointFromPosition(
    {@required String name,
    Position position,
    bool withAddress = false,
    LocationAccuracy locationAccuracy = LocationAccuracy.best,
    bool verbose = false}) async {
  name = name ?? "Current position";
  GeoPoint geoPoint;
  position ??=
      await Geolocator().getCurrentPosition(desiredAccuracy: locationAccuracy);
  Placemark placemark;
  if (withAddress == true) {
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    placemark = placemarks[0];
  }
  String number;
  String street;
  String locality;
  String sublocality;
  String postalCode;
  //subregion = placemark.subAdministratieArea;
  String region;
  String country;

  String slug = _slugify.slugify(name);
  int timestamp = position.timestamp.millisecondsSinceEpoch;
  double latitude = position.latitude;
  double longitude = position.longitude;
  double altitude = position.altitude;
  double speed = position.speed;
  double accuracy = position.accuracy;
  double speedAccuracy = position.speedAccuracy;
  double heading = position.heading;
  if (placemark != null) {
    number = placemark.subThoroughfare;
    street = placemark.thoroughfare;
    locality = placemark.locality;
    sublocality = placemark.subLocality;
    postalCode = placemark.postalCode;
    //subregion = placemark.subAdministratieArea;
    region = placemark.administrativeArea;
    country = placemark.country;

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
  }
  return geoPoint;
}