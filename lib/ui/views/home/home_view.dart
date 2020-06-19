import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
            child: Container(
          child: Center(
            child: InkWell(
              onTap: (){
                model.navigateToHome();
              },
              child: Text('BUILD')),
          ),
        )),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
