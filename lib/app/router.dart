import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/ui/views/startup/startup_view.dart';

abstract class Routes {
  static const startupViewRoute = '/startup';
  static const homeViewRoute = '/';
  static const onboardingViewRoute = '/onboarding';
  static const languageViewRoute = '/language';
  static const authenticationViewRoute = '/auth';
  static const nameViewRoute = '/name';
  static const businessViewRoute = '/business';
  static const mainViewRoute = '/main';
  static const addcustomerRoute = '/addcustomer';
  static const addCustomerManually = '/addCusMan';
  static const detailsViewRoute = '/details';
  static const supportViewRoute = '/support';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => StartupView(),
          settings: settings,
        );
      // case Routes.onboardingViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => OnboardingView(),
      //     settings: settings,
      //   );
      // case Routes.languageViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => LanguageView(),
      //     settings: settings,
      //   );
      // case Routes.addcustomerRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => AddCustomerView(),
      //   );
      // case Routes.languageViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => LanguageView(),
      //     settings: settings,
      //   );
      // case Routes.authenticationViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => AuthenticationView(),
      //     settings: settings,
      //   );
      // case Routes.nameViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => NameView(),
      //     settings: settings,
      //   );
      // case Routes.businessViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => BusinessView(),
      //     settings: settings,
      //   );
      // case Routes.supportViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => SupportPageView(),
      //     settings: settings,
      //   );
      case Routes.mainViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: settings,
        );
      // case Routes.homeViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => HomeView(),
      //     settings: settings,
      //   );
      // case Routes.detailsViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => DetailsView(),
      //     settings: settings,
      //   );
      // case Routes.addCustomerManually:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => AddCustomerManuallyView(),
      //     settings: settings,
      //   );
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
