import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/addcustomer/add_customer_view.dart';
import 'package:mycustomers/ui/views/home/home_view.dart';
import 'package:mycustomers/ui/views/onboarding/onboarding_view.dart';
import 'package:mycustomers/ui/views/language/language_view.dart';
import 'package:mycustomers/ui/views/phone/phone_view.dart';
import 'package:mycustomers/ui/views/startup/startup_view.dart'; 
import 'package:mycustomers/ui/views/otp/otp_view.dart';

import '../ui/views/details/details_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const homeViewRoute = '/home';
  static const addcustomerRoute = '/addcustomer';
  static const languageViewRoute = '/language';
  static const phoneViewRoute = '/phone';
  static const otpViewRoute = '/otp';
  static const detailsViewRoute = '/details';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => OnboardingView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );

      case Routes.addcustomerRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerView(),
        );
      case Routes.languageViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => LanguageView(),
          settings: settings,
        );
      case Routes.phoneViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => PhoneView(),
          settings: settings,
        );
      case Routes.otpViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => OTPView(),
          settings: settings,
        );
      case Routes.detailsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => DetailsView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// borrowed from auto_route:
// returns an error page routes with a helper message.
PageRoute unknownRoutePage(String routeName) => CupertinoPageRoute(
      builder: (ctx) => Scaffold(
        body: Container(
          color: Colors.redAccent,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  routeName == "/"
                      ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                      : 'Route name $routeName is not found!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              OutlineButton.icon(
                label: Text('Back'),
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ),
      ),
    );
