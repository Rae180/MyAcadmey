import 'package:flutter/material.dart';
import 'package:start/core/managers/string_manager.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case HomePage.routeName:
      //   return MaterialPageRoute(builder: (context) => HomePage());

      default:
        return unDefinedRoute();
    }
  }

  Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
