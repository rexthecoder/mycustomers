import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:mycustomers/ui/views/business/settings_page/settings_page_view.dart';
import 'package:mycustomers/ui/views/business/business_support_page/support_page.dart';
import 'package:mycustomers/ui/views/business/profile/addAssistant/addAssitant_view.dart';
import 'package:mycustomers/ui/views/business/profile/profile_page/profile_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/app_lock_settings_page/app_lock_settings_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/currency_settings_page/currency_settings_page_view.dart';
import 'package:mycustomers/ui/views/home/getstarted/getstarted_view.dart';
import 'package:mycustomers/ui/views/home/language/language_view.dart';
import 'package:mycustomers/ui/views/home/onboarding/onboarding_view.dart';
import 'package:mycustomers/ui/views/home/addcustomer/add_customer_view.dart';
import 'package:mycustomers/ui/views/home/signup/business/business_view.dart';
import 'package:mycustomers/ui/views/home/signup/verification/verification_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/ui/views/startup/startup_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const getstartedViewRoute = '/getstarted';
  static const onboardingViewRoute = '/onboarding';
  static const languageViewRoute = '/language';
  static const homeViewRoute = '/home';
  static const signinViewRoute = '/signin';
  static const signupViewRoute = '/signup';
  static const verificationViewRoute = '/verify';
  static const nameViewRoute = '/name';
  static const businessViewRoute = '/business';
  static const mainViewRoute = '/main';
  static const addcustomerRoute = '/addcustomer';
  static const addCustomerManually = '/addCusMan';
  static const detailsViewRoute = '/details';
  static const addCustomer = '/addCustomer';
  static const supportViewRoute = '/support';
  static const businessCardRoute = '/businessCard';
  static const bussinessSettingsPage ='/bussinessSettingsPage';
  static const addAssistantRoute = '/addAssistant';
  static const currencySettingsViewRoute = '/currencySettings';
  static const profileViewRoute = '/profile';
  static const appLockSettingsViewRoute = '/appLockSettings';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SettingsPage(),
          settings: settings,
        );
      case Routes.getstartedViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => GetStartedView(),
          settings: settings,
        );
      case Routes.onboardingViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => OnboardingView(),
          settings: settings,
        );
      case Routes.languageViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => LanguageView(),
          settings: settings,
        );
      case Routes.verificationViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => VerificationView(),
          settings: settings,
        );
      case Routes.mainViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: settings,
        );
      case Routes.addCustomer:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerView(),
          settings: settings,
        );
      case Routes.businessViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => BusinessView(),
          settings: settings,
        );
    case Routes.bussinessSettingsPage:
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SettingsPage(),
        settings: settings,
      );
      case Routes.profileViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ProfilePageView(),
          settings: settings,
        );
      // case Routes.addcustomerRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => AddCustomerView(),
      //   );
      // case Routes.signupViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => SignUpView(),
      //     settings: settings,
      //   );

      // case Routes.signinViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => SignInView(),
      //     settings: settings,
      //   )
      //   );
      case Routes.supportViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SupportPageView(),
          settings: settings,
        );
      case Routes.addAssistantRoute:
        return CupertinoPageRoute<dynamic>(
            builder: (context) => AddAssistantView(), settings: settings);
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
      case Routes.businessCardRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => BusinessCardPageView(),
          settings: settings,
        );
      case Routes.currencySettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => CurrencySettingsPageView(),
          settings: settings,
        );
      case Routes.appLockSettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AppLockSettingsPageView(),
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
