import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked_services/stacked_services.dart';
import './ui/shared/themes.dart' as themes;

import 'app/locator.dart';
import 'app/router.dart';

void main() {
  setupLocator();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  
  // Status bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]); // Settting preferred Screen Orientation
    return PlatformApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: true,
      android: (_) => MaterialAppData(
            theme: themes.primaryMaterialTheme,
            darkTheme: themes.darkMaterialTheme,
          ),
          ios: (_) => CupertinoAppData(
            theme: themes.primaryCupertinoTheme,
          ),
          
      initialRoute: Routes.startupViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}