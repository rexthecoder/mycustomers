import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

import 'create_business_viewmodel.dart';

// class CreateBusinessView extends StatelessWidget {
//   @override
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
          backgroundColor:Colors.transparent,
          bottomSheet: _PartialBuildForm(),
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

  @override
  Widget buildViewModelWidget(
      BuildContext context, CreateBusinessViewModel viewModel) {
    final _storeName = useTextEditingController();
    final _storeAddress = useTextEditingController();
    print('Building ${_storeName.text}');

    return Form(
      key: _businessFormPageKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.yMargin(context, 7)),
          Text(
            'NEW BUSINESS DETAILS',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.yMargin(context, 4),
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 5)),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: TextFormField(
              key: Key("storeName"),
              controller: _storeName,
              validator: (value) =>
                  (value.isEmpty) ? "Please enter store name" : null,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: SizeConfig.yMargin(context, 2),
                fontWeight: FontWeight.w300,
                color: Theme.of(context).cursorColor,
              ),
              decoration: InputDecoration(
                  labelText: "Enter your  store name",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: TextFormField(
              key: Key("storeAddress"),
              controller: _storeAddress,
              validator: (value) =>
                  (value.isEmpty) ? "Please enter store address" : null,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: SizeConfig.yMargin(context, 2),
                fontWeight: FontWeight.w300,
                color: Theme.of(context).cursorColor,
              ),
              decoration: InputDecoration(
                  labelText: "Enter your store address",
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 4)),
          CustomRaisedButton(
            btnColor: BrandColors.primary,
            txtColor: ThemeColors.background,
            btnText: 'Create new business',
            borderColor: BrandColors.primary,
            child: Container(),
            onPressed: () async {
              // viewModel.signUpTest();
              if (_businessFormPageKey.currentState.validate()) {
                //Dismiss keyboard during async call
                FocusScope.of(context).requestFocus(FocusNode());

                //Call Function to Signin
                viewModel.updateUser(
                    _storeName.text.trim(), _storeAddress.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
