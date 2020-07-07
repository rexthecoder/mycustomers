import 'package:flutter/material.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.nonReactive(
      builder: (context, model, child) => Center(
        child: LoadingAnimation(),
      ),
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.setup(),
    );
  }
}
