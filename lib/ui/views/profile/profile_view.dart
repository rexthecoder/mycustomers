import 'package:flutter/material.dart';
import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
import 'package:stacked/stacked.dart';


import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: UnderConstruction(),
            //TODO: Implement Profile Page
      ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
