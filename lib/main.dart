import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart'; 
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
    

  //    /* 
  //   1. Setup for screenutil, only needed once here
  //   2. screen resolution (in px) according to phone screen
  //   3. Import screen util to all views
  //   4. use in this manner E.g Container(width: 50.w, height:200.h)
  //   */
  //   ScreenUtil.init(context, width: width, height: height, allowFontScaling: true);

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