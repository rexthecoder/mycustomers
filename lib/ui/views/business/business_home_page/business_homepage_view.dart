import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/business/profile/profile_page/profile_page_view.dart';
import 'package:stacked/stacked.dart';


import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: ProfilePageView(),
      ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }
}
