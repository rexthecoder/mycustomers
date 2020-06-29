import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycustomers/core/mixings/validators.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'verification_viewmodel.dart';

class VerificationView extends StatelessWidget with Validators {
  static final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<VerificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _pageKey,
        body: HomeBackgroundWidget(
          height: height,
          width: width,
          child: Form(
            key: _formPageKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.yMargin(context, 7)),
                Text(
                  'VERIFY CODE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 4),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 5)),

                Padding(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 3)),
                  child: PinCodeTextField(
                    length: 4,
                    obsecureText: false,
                    animationType: AnimationType.scale,
                    textInputType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      selectedColor: Colors.black,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      borderWidth: 1,
                      fieldWidth: SizeConfig.yMargin(context, 8),
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    //errorAnimationController: errorController,
                    //controller: textEditingController,
                    autoDisposeControllers: false,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      //TODO: Listens and move below code to viewmodel

                      //   if (value != null && value.length == 6) {

                      // }
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Please enter 4-digit code we sent \nto your number as SMS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: SizeConfig.yMargin(context, 2),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 13)),
                InkWell(
                  onTap: () {
                    model.naviagateToNext();
                  },
                  child: btnAuth('Verify and Proceed', context),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 18)),
                Container(
                    width: SizeConfig.xMargin(context, 60),
                    child: CustomizeProgressIndicator(2, 4)),
                SizedBox(height: SizeConfig.yMargin(context, 6)),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => VerificationViewModel(),
    );
  }
}
