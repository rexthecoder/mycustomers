import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'otp_viewmodel.dart';
import '../../../core/mixings/validators.dart';
import '../../widgets/shared/custom_raised_button.dart';
import '../../widgets/shared/social_icon.dart';

class OTPView extends StatelessWidget with Validators {
//  StreamController<ErrorAnimationType> errorController;
//
//  final textEditingController = TextEditingController();

  /// A reusable text style
  /// Can be moved to a mixin or constant
  final regularTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    color: Colors.black,
  );

  /// Reusable height space weights
  /// Can be moved to a mixin or constant
  final mediumVerticalHeight = SizedBox(
    height: 16.0,
  );

  final smallVerticalHeight = SizedBox(
    height: 8.0,
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OTPViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: ScreenUtil.screenHeightDp * 0.7,
            width: ScreenUtil.screenWidthDp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/otp_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
            height: ScreenUtil.screenHeightDp * 0.35,
            width: ScreenUtil.screenWidthDp,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  width: ScreenUtil.screenWidthDp,
                  decoration: BoxDecoration(
                    color: Color(0xFF333CC1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      mediumVerticalHeight,
                      Text(
                        'PASTE FROM SMS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      smallVerticalHeight,
                      Expanded(
                        child: Text(
                          '0349',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil.screenHeightDp * 0.25,
                  width: ScreenUtil.screenWidthDp,
                  padding: EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
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
                            fieldWidth: ScreenUtil.screenWidthDp * 0.15,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          //errorAnimationController: errorController,
                          //controller: textEditingController,
                          autoDisposeControllers: false,
                          onCompleted: (v) {},
                          onChanged: (value) {},
                        ),
                      ),
                      smallVerticalHeight,
                      Text(
                        'Please enter 4-digit code we sent on \nyour number as SMS',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
      viewModelBuilder: () => OTPViewModel(),
    );
  }
}
