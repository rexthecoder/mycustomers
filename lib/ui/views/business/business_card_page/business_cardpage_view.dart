import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
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

    return ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
      builder: (context, model, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            await model.init();
            businessCardController.animateToPage(
              int.parse(model.businessCard.cardDesign),
              duration: new Duration(seconds: 2),
              curve: Curves.easeIn,
            );
          },
        );
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Business Card",
              style: TextStyle(
                color: Theme.of(context).cursorColor,
                fontSize: SizeConfig.textSize(context, 6),
              ),
            ),
            iconTheme:
                IconThemeData(color: Theme.of(context).textSelectionColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
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
                              onPageChanged: (value) =>
                                  model.updateBusinessCard(
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
                      txtColor: ThemeColors.background,
                      btnColor: BrandColors.primary,
                      btnText: "Save and Share",
                      borderColor: BrandColors.primary,
                      child: Container(),
                      onPressed: () {
                        screenshotController
                            .capture(
                          pixelRatio: ScreenUtil.pixelRatio,
                          delay: Duration(milliseconds: 10),
                        )
                            .then(
                          (File image) async {
                            //Capture Done
                            model.imageFile = image;
                            await model.saveBusinessCard();
                            FlushbarHelper.createSuccess(
                              duration: const Duration(seconds: 5),
                              message: 'Save Successful',
                            ).show(context);
                            model.shareImageAndText();
                          },
                        ).catchError(
                          (onError) {
                            FlushbarHelper.createError(
                              duration: const Duration(seconds: 5),
                              message: onError.toString(),
                            ).show(context);
                          },
                        );
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
        );
      },
      viewModelBuilder: () => BusinessCardPageViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}

class BusinessCardModal extends StatelessWidget {
  const BusinessCardModal({
    Key key,
    @required this.screenshotController,
  }) : super(key: key);

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    PageController businessCardController = PageController(initialPage: 0);

    return ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
      builder: (context, model, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            businessCardController.animateToPage(
              int.parse(model.businessCard.cardDesign),
              duration: new Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
        );
        return Container(
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
                  onPressed: () => businessCardController.previousPage(
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
        );
      },
      viewModelBuilder: () => BusinessCardPageViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}

class BottomSheetButtons extends StatelessWidget {
  final ScreenshotController screenshotController;

  const BottomSheetButtons({
    Key key,
    @required this.screenshotController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String share = 'assets/icons/svg/share.svg';

    return ViewModelBuilder<BusinessCardPageViewModel>.reactive(
      builder: (context, model, child) => Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CustomShareRaisedButton(
              txtColor: ThemeColors.background,
              btnColor: BrandColors.primary,
              btnText: 'Share',
              borderColor: BrandColors.primary,
              child: SvgPicture.asset(
                share,
                height: SizeConfig.xMargin(context, 4),
                color: ThemeColors.background,
              ),
              onPressed: () async {
                screenshotController
                    .capture(
                  pixelRatio: ScreenUtil.pixelRatio,
                  delay: Duration(milliseconds: 10),
                )
                    .then(
                  (File image) async {
                    model.imageFile = image;
                    await model.saveBusinessCard();
                    FlushbarHelper.createSuccess(
                      duration: const Duration(seconds: 5),
                      message: 'Sharing...',
                    ).show(context);
                    model.shareImageAndText();
                    FlushbarHelper.createSuccess(
                      duration: const Duration(seconds: 5),
                      message: 'Successful',
                    ).show(context);
                  },
                ).catchError(
                  (onError) {
                    FlushbarHelper.createError(
                      duration: const Duration(seconds: 5),
                      message: onError.toString(),
                    ).show(context);
                  },
                );
                return;
              },
            ),
          ),
          SizedBox(width: SizeConfig.xMargin(context, 3.0)),
          Expanded(
            flex: 1,
            child: CustomShareRaisedButton(
              txtColor: BrandColors.primary,
              btnColor: ThemeColors.background,
              btnText: 'Download',
              borderColor: BrandColors.primary,
              child: SvgPicture.asset(
                share,
                color: ThemeColors.background,
              ),
              onPressed: () async {
                screenshotController
                    .capture(
                  pixelRatio: ScreenUtil.pixelRatio,
                  delay: Duration(milliseconds: 10),
                )
                    .then((File image) async {
                  model.imageFile = image;
                  await model.saveBusinessCard();
                  FlushbarHelper.createSuccess(
                    duration: const Duration(seconds: 5),
                    message: 'downloading...',
                  ).show(context);
                  model.downloadImage();
                  FlushbarHelper.createSuccess(
                    duration: const Duration(seconds: 5),
                    message: 'Download Completed to internalStorage/myCustomer',
                  ).show(context);
                }).catchError((onError) {
                  FlushbarHelper.createError(
                    duration: const Duration(seconds: 5),
                    message: onError.toString(),
                  ).show(context);
                });
                return;
              },
            ),
            // Container(
            //   height: SizeConfig.yMargin(context, 9),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: BrandColors.primary),
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   child: FlatButton(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(32)),
            //     onPressed: () async {
            //       screenshotController
            //           .capture(
            //         pixelRatio: ScreenUtil.pixelRatio,
            //         delay: Duration(milliseconds: 10),
            //       )
            //           .then((File image) async {
            //         model.imageFile = image;
            //         await model.saveBusinessCard();
            //         FlushbarHelper.createSuccess(
            //           duration: const Duration(seconds: 5),
            //           message: 'downloading...',
            //         ).show(context);
            //         model.downloadImage();
            //         FlushbarHelper.createSuccess(
            //           duration: const Duration(seconds: 5),
            //           message:
            //               'Download Completed to internalStorage/myCustomer',
            //         ).show(context);
            //       }).catchError((onError) {
            //         print(onError.toString());
            //         FlushbarHelper.createError(
            //           duration: const Duration(seconds: 5),
            //           message: onError.toString(),
            //         ).show(context);
            //       });
            //       return;
            //     },
            //     child: Text(
            //       'Download',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: BrandColors.primary,
            //         fontSize: SizeConfig.textSize(context, 4.4),
            //       ),
            //     ),
            //   ),
            // ),
          )
        ],
      ),
      viewModelBuilder: () => BusinessCardPageViewModel(),
      onModelReady: (model) => model.init(),
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
        color: Theme.of(context).backgroundColor,
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
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onChange,
        textStyle: TextStyle(
          color: Theme.of(context).backgroundColor,
          fontSize: SizeConfig.textSize(context, 5),
        ),
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        selectorTextStyle: TextStyle(color: Theme.of(context).cursorColor),
        inputBorder: InputBorder.none,
        hintText: '903 9393 9383',
        formatInput: true,
      ),
    );
  }
}