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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'business_viewmodel.dart';

class BusinessView extends StatelessWidget {
  final String process;

  BusinessView({Key key, this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _businessPageKey = GlobalKey<ScaffoldState>();
    final ScrollController controller = new ScrollController();

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
              appBar: customizeAppBar(
                context,
                0,
                title: '',
                arrowColor: ThemeColors.background,
                backgroundColor: Colors.transparent,
              ),
              body: Container(
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.yMargin(context, 100),
                  minHeight: SizeConfig.yMargin(context, 100),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      SizeConfig.yMargin(context, 4),
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: _PartialBuildForm(
                    process: process,
//                    controller: controller,
                  ),
                ),
              ),
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
  final ScrollController controller;

  _PartialBuildForm({
    this.process,
    Key key,
    this.controller,
  }) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, BusinessViewModel viewModel) {
    var _storeName = useTextEditingController();
    var _storeAddress = useTextEditingController();
    var _fullName = useTextEditingController();
    var _emailAddress = useTextEditingController();
    var _phoneNUmber = useTextEditingController();
    var _tagLine = useTextEditingController();
//    final _storeNameFocus = FocusNode();
//    final _storeAddressFocus = FocusNode();
//    final _fullNameFocus = FocusNode();
//    final _emailAddressFocus = FocusNode();
//    final _phoneNUmberFocus = FocusNode();
//    final _tagLineFocus = FocusNode();

//    move() {
//      if (controller.position.pixels <
//          controller.position.pixels + SizeConfig.yMargin(context, 30)) {
//        Future.delayed(Duration(milliseconds: 600), () {
//          controller.animateTo(
//            controller.position.pixels + SizeConfig.yMargin(context, 30),
//            duration: new Duration(milliseconds: 300),
//            curve: Curves.easeInOut,
//          );
//        });
//      }
//    }

//    onFocus() {
//      if (_storeNameFocus.hasFocus ||
//          _storeAddressFocus.hasFocus ||
//          _fullNameFocus.hasFocus ||
//          _emailAddressFocus.hasFocus ||
//          _phoneNUmberFocus.hasFocus ||
//          _tagLineFocus.hasFocus) {
//        move();
//      }
//    }
//
//    onFocus();
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
//            Column(
//              children: <Widget>[
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
//                      focusNode: _fullNameFocus,
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
                    labelStyle: TextStyle(color: Theme.of(context).cursorColor),
                    labelText: AppLocalizations.of(context).enterYourFullName,
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.xMargin(context, 4),
                  right: SizeConfig.xMargin(context, 4),
                  bottom: SizeConfig.yMargin(context, 2)),
              child: TextFormField(
//                    focusNode: _emailAddressFocus,
                key: Key("email"),
                keyboardType: TextInputType.emailAddress,
                controller: _emailAddress,
                validator: (_) => viewModel.validateEmail(_emailAddress.text),
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: SizeConfig.yMargin(context, 2),
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).cursorColor,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Theme.of(context).cursorColor),
                    labelText: AppLocalizations.of(context)
                        .pleaseEnterYourEmailAddress,
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.xMargin(context, 4),
                  right: SizeConfig.xMargin(context, 4),
                  bottom: SizeConfig.yMargin(context, 2)),
              child: TextFormField(
//                    focusNode: _storeNameFocus,
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
                  labelStyle: TextStyle(color: Theme.of(context).cursorColor),
                  labelText: AppLocalizations.of(context).enterStoreName,
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                bottom: SizeConfig.yMargin(context, 1),
                left: SizeConfig.xMargin(context, 4),
                right: SizeConfig.xMargin(context, 4),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.gray[700]),
                color: Theme.of(context).backgroundColor,
                borderRadius:
                    BorderRadius.circular(SizeConfig.yMargin(context, 0.5)),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.xMargin(context, 4),
                      vertical: SizeConfig.yMargin(context, 0.3),
                    ),
                    child: InternationalPhoneNumberInput(
                      textFieldController: _phoneNUmber,
                      errorMessage: AppLocalizations.of(context).phoneNumber,
//                onInputChanged: onChange,
                      textStyle: TextStyle(
                        color: Theme.of(context).cursorColor,
                        fontSize: SizeConfig.textSize(context, 5),
                      ),
                      selectorType: PhoneInputSelectorType.DIALOG,
                      selectorTextStyle:
                          TextStyle(color: Theme.of(context).cursorColor),
                      inputBorder: InputBorder.none,
                      hintText: '903 9393 9383',
                      formatInput: true,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 1,
                    bottom: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      onPressed: () {
                        _phoneNUmber.value =
                            new TextEditingValue(text: viewModel.pNum);
                      },
                      child: Text('Use Default'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.xMargin(context, 4),
                  right: SizeConfig.xMargin(context, 4),
                  bottom: SizeConfig.yMargin(context, 2)),
              child: TextFormField(
//                    focusNode: _tagLineFocus,
                textCapitalization: TextCapitalization.sentences,
                key: Key("tagLine"),
                controller: _tagLine,
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
                    labelStyle: TextStyle(color: Theme.of(context).cursorColor),
                    labelText: AppLocalizations.of(context).companyTagLine,
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.xMargin(context, 4),
                  right: SizeConfig.xMargin(context, 4),
                  bottom: SizeConfig.yMargin(context, 2)),
              child: TextFormField(
//                      focusNode: _storeAddressFocus,
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
                  labelStyle: TextStyle(color: Theme.of(context).cursorColor),
                  labelText: AppLocalizations.of(context).enterStoreAddress,
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
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
            SizedBox(
              height: SizeConfig.yMargin(context, 5),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
//                Container(
//                  width: SizeConfig.xMargin(context, 80),
//                  child: process != 'signin'
//                      ? CustomizeProgressIndicator(4, 4)
//                      : Column(
//                    children: <Widget>[
//                      SizedBox(height: SizeConfig.yMargin(context, 5)),
//                      ColorizeAnimatedTextKit(
//                        speed: Duration(milliseconds: 500),
//                        repeatForever: true,
//                        text: ['Oops'],
//                        colors: [
//                          BrandColors.primary,
//                          BrandColors.secondary,
//                          BrandColors.yellow,
//                          BrandColors.orange,
//                        ],
//                        textStyle: TextStyle(
//                          // color: BrandColors.primary,
//                          fontWeight: FontWeight.w500,
//                          fontSize: SizeConfig.yMargin(context, 5),
//                        ),
//                      ),
//                      SizedBox(height: SizeConfig.yMargin(context, 2)),
//                      ColorizeAnimatedTextKit(
//                        // speed: Duration(milliseconds: 300),
//                        repeatForever: true,
//                        text: [
//                          "Seems you don't have a store yet",
//                          "Please create one"
//                        ],
//                        colors: [
//                          Colors.purple,
//                          Colors.blue,
//                          Colors.yellow,
//                          Colors.red,
//                        ],
//                        textStyle: TextStyle(
//                          // color: BrandColors.primary,
//                          fontWeight: FontWeight.w500,
//                          fontSize: SizeConfig.yMargin(context, 2.4),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                SizedBox(height: SizeConfig.yMargin(context, 4)),
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
