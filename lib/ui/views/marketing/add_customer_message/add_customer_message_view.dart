import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_customer_message_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(), // TODO: Implement Sliver AppBar
        body: SafeArea(
          child: Container(), // TODO: Implement Customers list
        ),
      ),
      viewModelBuilder: () => AddCustomerMessageViewModel(),
    );
  }
}