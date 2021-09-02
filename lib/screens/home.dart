import 'package:catcher/core/catcher.dart';
import 'package:cks_weather/configurations/string_manager.dart';
import 'package:cks_weather/screens/home_screen/home_screen.dart';
import 'package:cks_weather/services/database/hive_database.dart';
import 'package:cks_weather/theme/main_theme.dart';
import 'package:cks_weather/util/injection/injection.dart';
import 'package:cks_weather/util/navigation/navigation_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

/// Entry point of the app.
class CksWeather extends StatefulWidget {
  /// Constructor with dependencies
  CksWeather({
    NavigationRouter? router,
    StringManager? stringManager,
    HiveDatabase? hiveDatabase,
  })  : _stringManager = stringManager ?? getIt<StringManager>(),
        _router = router ?? getIt<NavigationRouter>(),
        _hiveDatabase = hiveDatabase ?? getIt<HiveDatabase>();

  final NavigationRouter _router;
  final StringManager _stringManager;
  final MainTheme _theme = MainTheme();
  final HiveDatabase _hiveDatabase;

  @override
  _CksWeatherState createState() => _CksWeatherState();
}

class _CksWeatherState extends State<CksWeather> {
  final GlobalKey<NavigatorState>? navigatorKey = Catcher.navigatorKey;

  @override
  Widget build(BuildContext context) {
    /// Let's keep the orientation on portrait only
    /// It helps to avoid some errors since UI not handled well
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return ValueListenableBuilder<Box<bool>>(
        valueListenable: widget._hiveDatabase.getDarkModeListenable(),
        builder: (context, box, localWidget) {
          final darkMode = box.get('darkMode', defaultValue: false) ?? false;
          return MaterialApp(
            navigatorKey: navigatorKey,
            builder: (BuildContext context, Widget? child) {
              child ??= HomeScreen();
              return MediaQuery(
                /// Just to avoid default scaling issues with various mobile configs
                /// Ex, Sometimes we scale up the font size in mobile which mess up with app by increasing
                /// all font sizes, so it's good to avoid in initial stages
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, boldText: false),
                child: Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: child,
                ),
              );
            },
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            title: widget._stringManager.appName,
            theme: widget._theme.lightTheme,
            darkTheme: widget._theme.darkTheme,
            onGenerateRoute: widget._router.generateRoute,
            initialRoute: widget._router.initialRoute,
          );
        });
  }
}
