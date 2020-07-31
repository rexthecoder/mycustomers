import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
import 'package:stacked/stacked.dart';

import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrivacyPolicyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(
          context,
          1.0,
          title: 'Privacy Policy',
          arrowColor: BrandColors.primary,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: UnderConstruction(),
        ),
      ),
      viewModelBuilder: () => PrivacyPolicyViewModel(),
      onModelReady: (model) => model.openDoc(),
    );
  }
}
