import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/business/settings/language_settings/language_page_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:stacked/stacked.dart';


import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child:LanguageSettingPageView(),
      ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }
}
