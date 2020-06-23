import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_cardpage_viewmodel.dart';

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
                  // TODO BUSINESS CARD
                  _BusinessCard(),
                  SizedBox(
                    height: 10.sp,
                  ),
                  // TODO STORE NAME FORM FIELD
                  _DefaultFormField(),
                  // TODO PERSONAL NAME FORM FIELD
                  _DefaultFormField(),
                  // TODO PHONE NUMBER FORM FIELD
                  _DefaultFormField(),
                  // TODO EMAIL ADDRESS FORM FIELD
                  _DefaultFormField(),
                  // TODO SHOP/OFFICE ADDRESS FORM FIELD
                  _DefaultFormField(),
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
    var text = useTextEditingController();
    return Container();
  }
}

class _BusinessCard extends HookViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    var text = useTextEditingController();
    return Stack(
      children: <Widget>[
        Container(
          height: ScreenUtil.defaultHeight / 8,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/business_card.png"),
                fit: BoxFit.contain),
          ),
        ),
        Positioned(
          top: 20.sp,
          left: 150.sp,
//          right: 20.sp,
          child: Text(
            "Store Name".toUpperCase(),
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 150.sp,
          bottom: 90.sp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 15.sp,
                  ),
                  Text(
                    " Personal Name",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: 15.sp,
                  ),
                  Text(
                    " Phone Number",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    size: 15.sp,
                  ),
                  Text(
                    " Email Address",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.sp,
          left: 150.sp,
          child: Text(
            "Store Name",
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _DefaultFormField extends HookViewModelWidget<BusinessCardPageViewModel> {
  _DefaultFormField({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    var text = useTextEditingController();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D1D1)),
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Store Name",
          hintStyle: TextStyle(
            fontSize: 20.sp,
            color: const Color.fromRGBO(25, 25, 25, 0.6),
          ),
        ),
      ),
    );
  }
}
