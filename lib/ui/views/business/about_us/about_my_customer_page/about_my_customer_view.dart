import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
import 'package:stacked/stacked.dart';

import 'about_my_customer_viewmodel.dart';

class AboutMyCustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutMyCustomerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(
          context,
          1.0,
          title: 'About myCustomer',
          arrowColor: BrandColors.primary,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: UnderConstruction(),
        ),
      ),
      viewModelBuilder: () => AboutMyCustomerViewModel(),
      onModelReady: (model) => model.openDoc(),
    );
  }
}
