import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/connectivity/connectivity_services.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:mycustomers/core/services/stoppable_services.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/views/business/settings/enter_pin_page/enter_pin_view.dart';
import 'package:stacked_services/stacked_services.dart';

/// A manager to start/stop [StoppableService]s when the app goes/returns into/from the background
class LifeCycleManager extends StatefulWidget {
  final Widget child;

  const LifeCycleManager({Key key, this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  List<StoppableService> servicesToManage = [
    locator<ConnectivityService>(),
  ];


  final PasswordManagerService _passwordManagerService = locator<PasswordManagerService>();
  final NavigationService _navigationService = locator<NavigationService>();
  Completer<bool> _clearForPush = Completer<bool>();
  AppLifecycleState _lifecycleState;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<bool> didPushRoute(String route) async {
    if (_lifecycleState == AppLifecycleState.paused) {
      _clearForPush = Completer();
    }
    return await _clearForPush.future;
  }

  Future<void> handleStateChange(AppLifecycleState state) async {
    Logger.d('myCustomer App life cycle change to $state');
    _clearForPush = Completer();
    if (state == AppLifecycleState.resumed) {
      if (_passwordManagerService.isPinSet) {
        await _navigationService.navigateToView(EnterPinView());
      }
      _clearForPush.complete(true);
    }
    servicesToManage.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _lifecycleState = state;
    handleStateChange(state);
  }
}
