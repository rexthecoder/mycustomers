import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_cardpage_viewmodel.dart';

part '../../../widgets/business/business_card_page/business_card_widget.dart';

class BusinessCardPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

    return ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Business Card",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _BusinessCard(),
                  SizedBox(
                    height: 10.sp,
                  ),
                  _BusinessCardForm(),
                  CustomShareRaisedButton(
                    label: "Share",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessCardPageViewModel(),
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
          // TODO VALIDATE PERSONAL NAME FORM FIELD
          _DefaultFormField(
            label: "Personal Name",
            onChange: (value) => model.updateBusinessCard(personalName: value),
          ),
          // TODO VALIDATE PHONE NUMBER FORM FIELD
          _DefaultFormField(
            label: "Phone Number",
            onChange: (value) => model.updateBusinessCard(phoneNumber: value),
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
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D1D1)),
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: TextFormField(
        onChanged: onChange,
        validator: validate,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 20.sp,
            color: const Color.fromRGBO(25, 25, 25, 0.6),
          ),
        ),
      ),
    );
  }
}
