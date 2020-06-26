import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 375, height: 812,);

return ViewModelBuilder<StartupViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.setup(),
    );
  }
}