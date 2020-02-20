import 'package:flutter/material.dart';
import 'package:testing/router/paths.dart';
import 'package:testing/widgets/favourite_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case FAVORITE:
      return MaterialPageRoute(builder: (context) => FavouritePage());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
