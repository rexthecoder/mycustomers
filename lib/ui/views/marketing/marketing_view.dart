import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'marketing_viewmodel.dart';

class MarketingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: Container(
          child: Center(
            child: Text('Welcome Developer \n You Can BUILD HERE'),
          ),
        )),
      ),
      viewModelBuilder: () => MarketingViewModel(),
    );
  }
}
