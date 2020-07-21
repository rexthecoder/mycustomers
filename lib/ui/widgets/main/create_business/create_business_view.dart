import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

import 'create_business_viewmodel.dart';

Widget createBusinessDialog(BuildContext context, DialogRequest request) {
  return CreateBusinessView();
}

class CreateBusinessView extends StatelessWidget {
  final _businessPageKey = GlobalKey<ScaffoldState>();

  CreateBusinessView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateBusinessViewModel>.nonReactive(
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: BrandColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          key: _businessPageKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          bottomSheet: _PartialBuildForm(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: BrandColors.primary),
            backgroundColor: Theme.of(context).backgroundColor,
            centerTitle: true,
            title: Text(
              'Add Business',
              style: TextStyle(
                color: Theme.of(context).cursorColor,
                fontSize: SizeConfig.textSize(context, 6),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CreateBusinessViewModel(),
    );
  }
}
// }

class _PartialBuildForm extends HookViewModelWidget<CreateBusinessViewModel> {
  static final _businessFormPageKey = GlobalKey<FormState>();

  _PartialBuildForm({Key key}) : super(key: key, reactive: false);

  final String edit = 'assets/icons/svg/edit.svg';

  @override
  Widget buildViewModelWidget(
      BuildContext context, CreateBusinessViewModel viewModel) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Form(
        key: _businessFormPageKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(context, 5),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.yMargin(context, 5),
              ),
              TextFormField(
                onChanged: (value) => viewModel.updateStoreName(value),
                validator: (value) =>
                    (value.isEmpty) ? "Please enter business name" : null,
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  color: Theme.of(context).cursorColor,
                ),
                decoration: InputDecoration(
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.xMargin(context, 5)),
                    child: SvgPicture.asset(
                      edit,
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor.withOpacity(0.5),
                  ),
                  labelText: "Business name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 3),
              ),
              TextFormField(
                maxLines: 6,
                minLines: 4,
                onChanged: (value) => viewModel.updateStoreAddress(value),
                validator: (value) =>
                    (value.isEmpty) ? "Please enter about business" : null,
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  color: Theme.of(context).cursorColor,
                ),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.xMargin(context, 5)),
                    child: SvgPicture.asset(
                      edit,
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor.withOpacity(0.5),
                  ),
                  labelText: "About Business",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 3),
              ),
              ButtonTheme(
                minWidth: SizeConfig.xMargin(context, 90),
                height: SizeConfig.yMargin(context, 9),
                child: RaisedButton(
                  onPressed: () {
                    if (_businessFormPageKey.currentState.validate()) {
                      viewModel.updateUser();
                    }
                  },
                  child: Text(
                    'Create new business',
                    style: TextStyle(
                      color: ThemeColors.background,
                      fontSize: SizeConfig.textSize(context, 5),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: BrandColors.primary,
                ),
              ),
//          CustomRaisedButton(
//            btnColor: BrandColors.primary,
//            txtColor: ThemeColors.background,
//            btnText: 'Create new business',
//            borderColor: BrandColors.primary,
//            child: Container(),
//            onPressed: () async {
//              // viewModel.signUpTest();
//              if (_businessFormPageKey.currentState.validate()) {
//                //Dismiss keyboard during async call
//                FocusScope.of(context).requestFocus(
//                  FocusNode(),
//                );
//
//                //Call Function to Signin
////                viewModel.updateUser(
////                    _storeName.text.trim(), _storeAddress.text.trim());
//              }
//            },
//          ),
            ],
          ),
        ),
      ),
    );
  }
}
