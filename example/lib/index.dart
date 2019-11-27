import 'package:flutter/material.dart';

/// Home page
class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chartflo")),
        body: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: <Widget>[
                _ExampleTile(
                  title: "Simple",
                  iconData: Icons.location_on,
                  route: "/simple",
                ),
                _ExampleTile(
                  title: "Stream",
                  iconData: Icons.satellite,
                  route: "/stream",
                ),
              ],
            )));
  }
}

class _ExampleTile extends StatelessWidget {
  const _ExampleTile(
      {@required this.iconData, @required this.title, @required this.route});

  final IconData iconData;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(children: <Widget>[
        Icon(iconData, size: 65.0, color: Colors.grey),
        Padding(padding: const EdgeInsets.all(5.0), child: Text(title)),
      ]),
      onTap: () => Navigator.of(context).pushNamed(route),
    );
  }
}
