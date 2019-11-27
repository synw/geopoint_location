import 'package:flutter/material.dart';

import 'index.dart';
import 'simple.dart';
import 'stream.dart';

final routes = {
  '/simple': (BuildContext context) => SimplePage(),
  '/stream': (BuildContext context) => StreamPage(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geopoint location demo',
      home: IndexPage(),
      routes: routes,
    );
  }
}
