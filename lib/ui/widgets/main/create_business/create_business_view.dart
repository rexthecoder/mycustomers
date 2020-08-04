import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'create_business_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

Widget createBusinessDialog(BuildContext context, DialogRequest request) {
  return CreateBusinessView();
}

class CreateBusinessView extends StatelessWidget {
  static final _businessPageKey = GlobalKey<ScaffoldState>();

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
          body: _PartialCreateBusinessBuildForm(),
          appBar: customizeAppBar(context, 0,
              title: 'Add Business',
              arrowColor: Theme.of(context).textSelectionColor,
              backgroundColor: Theme.of(context).backgroundColor),
        ),
      ),
      viewModelBuilder: () => CreateBusinessViewModel(),
    );
  }
}
// }

class _PartialCreateBusinessBuildForm
    extends HookViewModelWidget<CreateBusinessViewModel> {
  static final _businessFormPageKey =
      GlobalKey<FormState>(debugLabel: 'businessForm');

  _PartialCreateBusinessBuildForm({Key key}) : super(key: key, reactive: false);

  final String edit = 'assets/icons/svg/edit.svg';

  @override
  Widget buildViewModelWidget(
      BuildContext context, CreateBusinessViewModel viewModel) {
    var _businessNameController = useTextEditingController();
    var _aboutBusinessController = useTextEditingController();
    var _phoneNUmber = useTextEditingController();

    return SingleChildScrollView(
      child: Container(
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
                  textCapitalization: TextCapitalization.sentences,
                  key: Key('businessName'),
                  controller: _businessNameController,
                  onChanged: (value) => viewModel.updateStoreName(value),
                  validator: (value) =>
                      (value.isEmpty) ? "Please enter business name" : null,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.xMargin(context, 5)),
                      child: SvgPicture.asset(
                        edit,
                        color: Theme.of(context).cursorColor.withOpacity(0.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                    labelText: AppLocalizations.of(context).businessName,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  key: Key('email'),
                  controller: _businessNameController,
                  onChanged: (value) => viewModel.updateStoreName(value),
                  validator: (value) =>
                      (value.isEmpty) ? "Please enter business name" : null,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.xMargin(context, 5)),
                      child: SvgPicture.asset(
                        edit,
                        color: Theme.of(context).cursorColor.withOpacity(0.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                    labelText:
                        AppLocalizations.of(context).pleaseEnterYourEmailAddress,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                Container(
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
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  key: Key('tagLine'),
                  controller: _businessNameController,
                  onChanged: (value) => viewModel.updateStoreName(value),
                  validator: (value) =>
                      (value.isEmpty) ? "Please enter business name" : null,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.xMargin(context, 5)),
                      child: SvgPicture.asset(
                        edit,
                        color: Theme.of(context).cursorColor.withOpacity(0.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                    labelText: AppLocalizations.of(context).companyTagLine,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  key: Key('businessDesc'),
                  controller: _aboutBusinessController,
                  maxLines: 6,
                  minLines: 4,
                  onChanged: (value) => viewModel.updateStoreAddress(value),
                  validator: (value) =>
                      (value.isEmpty) ? "Please enter business address" : null,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    color: Theme.of(context).cursorColor,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.xMargin(context, 5)),
                      child: SvgPicture.asset(
                        edit,
                        color: Theme.of(context).cursorColor.withOpacity(0.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      color: Theme.of(context).cursorColor.withOpacity(0.5),
                    ),
                    labelText: "Business Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                CustomRaisedButton(
                  txtColor: ThemeColors.background,
                  btnColor: BrandColors.primary,
                  btnText: 'Create new business',
                  borderColor: BrandColors.primary,
                  child: Container(),
                  onPressed: () {
                    //Validation
                    if (_businessFormPageKey.currentState.validate()) {
                      //Dismiss keyboard during async call
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );

                      //Call Function to AddStore
                      viewModel.updateUser();
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 5),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
