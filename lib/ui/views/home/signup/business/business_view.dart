import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'business_viewmodel.dart';

class BusinessView extends StatelessWidget {
  final String process;
  BusinessView({Key key, this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _businessPageKey = GlobalKey<ScaffoldState>();

    return ViewModelBuilder<BusinessViewModel>.reactive(
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: BrandColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () {
              return flusher(
                  'Sorry, you will need to register a business to access myCustomer',
                  context);
            },
            child: Scaffold(
              key: _businessPageKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: BrandColors.primary,
              body:
                  CustomBackground(child: _PartialBuildForm(process: process)),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessViewModel(),
    );
  }
}

class _PartialBuildForm extends HookViewModelWidget<BusinessViewModel> {
  static final _businessFormPageKey = GlobalKey<FormState>();
  final String process;

  _PartialBuildForm({this.process, Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, BusinessViewModel viewModel) {
    var _storeName = useTextEditingController();
    var _storeAddress = useTextEditingController();
    var _fullName = useTextEditingController();
    var _emailAddress = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.xMargin(context, 7)),
              topRight: Radius.circular(SizeConfig.xMargin(context, 7)))),
      child: Form(
        key: _businessFormPageKey,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Text(
                    process != 'signin'
                        ? AppLocalizations.of(context).businessDetails
                        : 'Create a business'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: SizeConfig.yMargin(context, 4),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Text(
                    process != 'signin'
                        ? AppLocalizations.of(context).oneLastStep
                        : '',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.xMargin(context, 4),
                        right: SizeConfig.xMargin(context, 4),
                        bottom: SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      key: Key("fullname"),
                      controller: _fullName,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseEnterYourFullName
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).cursorColor),
                          labelText:
                              AppLocalizations.of(context).enterYourFullName,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.xMargin(context, 4),
                        right: SizeConfig.xMargin(context, 4),
                        bottom: SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      key: Key("email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailAddress,
                      validator: (_) =>
                          viewModel.validateEmail(_emailAddress.text),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).cursorColor),
                          labelText: AppLocalizations.of(context)
                              .pleaseEnterYourEmailAddress,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.xMargin(context, 4),
                        right: SizeConfig.xMargin(context, 4),
                        bottom: SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      key: Key("storeName"),
                      controller: _storeName,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseStoreName
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).cursorColor),
                          labelText:
                              AppLocalizations.of(context).enterStoreName,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.xMargin(context, 4),
                        right: SizeConfig.xMargin(context, 4),
                        bottom: SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      key: Key("storeAddress"),
                      controller: _storeAddress,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseStoreAddress
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).cursorColor),
                          labelText:
                              AppLocalizations.of(context).enterStoreAddress,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
            CustomRaisedButton(
              btnColor: BrandColors.primary,
              txtColor: ThemeColors.background,
              btnText: process != 'signin'
                  ? AppLocalizations.of(context).submitAndFinish
                  : 'Submit',
              borderColor: BrandColors.primary,
              child: Container(),
              onPressed: () async {
                // viewModel.signUpTest();
                if (_businessFormPageKey.currentState.validate()) {
                  //Dismiss keyboard during async call
                  FocusScope.of(context).requestFocus(FocusNode());

                  //Call Function to Signin
                  viewModel.updateUserDeets(
                      _fullName.text.trim(), _emailAddress.text.trim());
                  viewModel.updateUser(
                      _storeName.text.trim(), _storeAddress.text.trim());
                }
              },
            ),
            SizedBox(height: SizeConfig.yMargin(context, 6)),
            Container(
              width: SizeConfig.xMargin(context, 80),
              child: process != 'signin'
                  ? CustomizeProgressIndicator(4, 4)
                  : Column(
                      children: <Widget>[
                        SizedBox(height: SizeConfig.yMargin(context, 5)),
                        ColorizeAnimatedTextKit(
                          speed: Duration(milliseconds: 500),
                          repeatForever: true,
                          text: ['Oops'],
                          colors: [
                            BrandColors.primary,
                            BrandColors.secondary,
                            BrandColors.yellow,
                            BrandColors.orange,
                          ],
                          textStyle: TextStyle(
                            // color: BrandColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.yMargin(context, 5),
                          ),
                        ),
                        SizedBox(height: SizeConfig.yMargin(context, 2)),
                        ColorizeAnimatedTextKit(
                          // speed: Duration(milliseconds: 300),
                          repeatForever: true,
                          text: [
                            "Seems you don't have a store yet",
                            "Please create one"
                          ],
                          colors: [
                            Colors.purple,
                            Colors.blue,
                            Colors.yellow,
                            Colors.red,
                          ],
                          textStyle: TextStyle(
                            // color: BrandColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.yMargin(context, 2.4),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: SizeConfig.yMargin(context, 4)),
          ],
        ),
      ),
    );
  }
}
