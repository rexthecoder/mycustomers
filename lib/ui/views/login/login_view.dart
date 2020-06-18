import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
            child: Container(
          child: Center(
            child: Text('Welcome Developer \n You Can BUILD HERE'),
          ),
        )),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
