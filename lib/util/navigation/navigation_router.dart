import 'package:cks_weather/blocs/home_bloc.dart';
import 'package:cks_weather/screens/home_screen/home_screen.dart';
import 'package:cks_weather/util/injection/injection.dart';
import 'package:cks_weather/util/navigation/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

/// NavigationRouter class for app navigation.
class NavigationRouter {
  /// Constructor with dependencies
  NavigationRouter({
    Logger? logger,
  }) : _logger = logger ?? getIt<Logger>();

  final Logger _logger;

  /// Define the initial screen of the app.
  String get initialRoute => homeScreen;

  /// The available routes for the app.
  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    // Log the route.
    _logger.d('Route: ${routeSettings.name}');

    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (BuildContext context) => BlocProvider<HomeBloc>(
                  create: (_) => getIt<HomeBloc>(),
                  child: HomeScreen(),
                ));
      default:
        _logger.e('No route defined for ${routeSettings.name}');

        /// Handling if any errors occurred while navigating between screens
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (BuildContext context) => Align(
                  child: Text("This route ${routeSettings.name} is not defined"),
                ));
    }
  }
}
