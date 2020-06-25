import 'package:device_preview/device_preview.dart';  
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:stacked_services/stacked_services.dart';
import './ui/shared/themes.dart' as themes;

import 'app/locator.dart';
import 'app/router.dart';

void main() {
  setupLocator();

  // runApp(App());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

  // Status bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]); // Settting preferred Screen Orientation
    return MaterialApp(
     builder: DevicePreview.appBuilder,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: themes.primaryMaterialTheme,
      darkTheme: themes.darkMaterialTheme,
      debugShowCheckedModeBanner: true,
      initialRoute: Routes.startupViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}