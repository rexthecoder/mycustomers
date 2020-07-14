import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/extensions/string_extension.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flushbar/flushbar_helper.dart';

import 'business_cardpage_viewmodel.dart';

part '../../../widgets/business/business_card_page/business_card_widget.dart';

class BusinessCardPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    PageController businessCardController = PageController(initialPage: 0);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

//    List<Widget> businessCards = ;

    return ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ThemeColors.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Business Card",
            style: TextStyle(
              color: ThemeColors.black,
              fontSize: SizeConfig.textSize(context, 6),
            ),
          ),
          iconTheme: IconThemeData(color: BrandColors.primary),
        ),
        backgroundColor: ThemeColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.xMargin(context, 4),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.yMargin(context, 30),
                    child: Stack(
                      children: <Widget>[
                        Screenshot(
                          controller: screenshotController,
                          child: PageView(
                            onPageChanged: (value) => model.updateBusinessCard(
                              cardDesign: value.toString(),
                            ),
                            allowImplicitScrolling: true,
                            controller: businessCardController,
                            children: <Widget>[
                              _BusinessCard1(),
                              _BusinessCard2(),
                              _BusinessCard3(),
                              _BusinessCard4(),
                            ],
                          ),
                        ),
                        Positioned(
                          left: SizeConfig.xMargin(context, 2),
                          top: SizeConfig.yMargin(context, 10),
                          bottom: SizeConfig.yMargin(context, 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: ThemeColors.error,
                              size: SizeConfig.textSize(context, 10),
                            ),
                            onPressed: () =>
                                businessCardController.previousPage(
                              duration: new Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.xMargin(context, 2),
                          top: SizeConfig.yMargin(context, 10),
                          bottom: SizeConfig.yMargin(context, 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_right,
                              color: ThemeColors.error,
                              size: SizeConfig.textSize(context, 10),
                            ),
                            onPressed: () => businessCardController.nextPage(
                              duration: new Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 3),
                  ),
                  _BusinessCardForm(),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 1),
                  ),
                  CustomShareRaisedButton(
                    label: "Save and Share",
                    onPressed: () {
                      screenshotController
                          .capture(
                        pixelRatio: ScreenUtil.pixelRatio,
                        delay: Duration(milliseconds: 10),
                      )
                          .then((File image) async {
                        //Capture Done
                        model.imageFile = image;
                        await model.saveBusinessCard();
                        FlushbarHelper.createSuccess(
                          duration: const Duration(seconds: 5),
                          message: 'Save Successful',
                        ).show(context);
                        model.shareImageAndText();
                      }).catchError((onError) {
                        print(onError.toString());
                        FlushbarHelper.createError(
                          duration: const Duration(seconds: 5),
                          message: onError.toString(),
                        ).show(context);
                      });
                      return;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessCardPageViewModel(),
      onModelReady: (model) async {
        await model.init();
        businessCardController.animateToPage(
          int.parse(model.businessCard.cardDesign),
          duration: new Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        return;
      },
    );
  }
}

class _BusinessCardForm extends HookViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCardForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Form(
      autovalidate: true,
      child: Column(
        children: <Widget>[
          // TODO VALIDATE STORE NAME FORM FIELD
          _DefaultFormField(
            label: "Store Name",
            onChange: (value) => model.updateBusinessCard(storeName: value),
          ),
          // TODO VALIDATE TAG LINE FORM FIELD
          _DefaultFormField(
            label: "Company Tag Line",
            onChange: (value) => model.updateBusinessCard(tagLine: value),
          ),
          // TODO VALIDATE PERSONAL NAME FORM FIELD
          _DefaultFormField(
            label: "Personal Name",
            onChange: (value) => model.updateBusinessCard(personalName: value),
          ),
          // TODO VALIDATE POSITION FORM FIELD
          _DefaultFormField(
            label: "Position",
            onChange: (value) => model.updateBusinessCard(position: value),
          ),
          _DefaultPhoneFormField(
            label: "Phone Number",
            onChange: (PhoneNumber value) =>
                model.updateBusinessCard(phoneNumber: value.phoneNumber),
          ),
          // TODO VALIDATE EMAIL ADDRESS FORM FIELD
          _DefaultFormField(
            label: "Email Address",
            onChange: (value) => model.updateBusinessCard(emailAddress: value),
          ),
          // TODO VALIDATE SHOP/OFFICE ADDRESS FORM FIELD
          _DefaultFormField(
            label: "Shop/Office Address",
            onChange: (value) {
              model.updateBusinessCard(address: value);
            },
          ),
        ],
      ),
    );
  }
}

class _DefaultFormField extends HookViewModelWidget<BusinessCardPageViewModel> {
  final String label;
  final onChange;
  final validate;

  _DefaultFormField({this.validate, this.onChange, this.label, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.yMargin(context, 1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 4),
        vertical: SizeConfig.yMargin(context, 0.5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.gray[700]),
        color: ThemeColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: onChange,
        validator: validate,
        cursorColor: ThemeColors.gray[800],
        style: TextStyle(
          color: ThemeColors.black,
          fontSize: SizeConfig.textSize(context, 5),
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontSize: SizeConfig.textSize(context, 5),
            color: ThemeColors.gray[700],
          ),
        ),
      ),
    );
  }
}

class _DefaultPhoneFormField
    extends HookViewModelWidget<BusinessCardPageViewModel> {
  final String label;
  final onChange;
  final validate;

  _DefaultPhoneFormField({this.validate, this.onChange, this.label, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1)),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.gray[700]),
        color: ThemeColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onChange,
        textStyle: TextStyle(
          color: ThemeColors.black,
          fontSize: SizeConfig.textSize(context, 5),
        ),
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        selectorTextStyle: TextStyle(color: Colors.black),
        inputBorder: InputBorder.none,
        hintText: '903 9393 9383',
        formatInput: true,
      ),
    );
  }
}
