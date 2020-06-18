import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import 'signup_viewmodel.dart';


class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
            child: Container(
          child: Center(
            child: Text('Welcome Developer \n You Can BUILD HERE'),
          ),
        )),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
