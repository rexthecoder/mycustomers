import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'signin_viewmodel.dart';

class SignInView extends StatelessWidget {
  TextEditingController _inputSigninNumberController;
  TextEditingController _userPasswordController;

  static final _signinFormPageKey = GlobalKey<FormState>();
  final _signinPageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SignInViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        key: _signinPageKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: BrandColors.primary,
        body: CustomBackground(child: buildForm(context, model)),
      ),
      viewModelBuilder: () => SignInViewModel(),
    );
  }

  Widget buildForm(BuildContext context, SignInViewModel model) {
    return Form(
      key: _signinFormPageKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.yMargin(context, 3)),
          Text(
            'SIGN IN',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.textSize(context, 6),
            ),
          ),
          // SizedBox(height: SizeConfig.xMargin(context, 2)),
          // Text(
          //   'Please Enter your Phone number',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: SizeConfig.yMargin(context, 2),
          //   ),
          // ),
          SizedBox(height: SizeConfig.yMargin(context, 1.3)),
          Container(
            height: SizeConfig.yMargin(context, 14),
            width: SizeConfig.xMargin(context, 90),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                //TODO:
              },
              onInputValidated: (bool value) {
                //TODO: Validation
              },
              ignoreBlank: false,
              autoValidate: false,
              // countries: ['NG', 'GH', 'BJ' 'TG', 'CI'],
              errorMessage: 'Invalid Phone Number',
              selectorType: PhoneInputSelectorType.DIALOG,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: model.number,
              textFieldController: _inputSigninNumberController,
              // inputBorder: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextFormField(
                  key: Key("userpassword"),
                  controller: _userPasswordController,
                  obscureText: model.obscureText,
                  validator: (value) =>
                      (value.isEmpty) ? "Enter a valid password" : null,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: SizeConfig.yMargin(context, 2),
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Password",
                
                    // border: OutlineInputBorder(),
                  ),
                ),
                GestureDetector(
                child: Icon(
                  // Based on obsecureText state choose the icon
                  model.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: BrandColors.primary,
                ),
                onTap: () {
                  // Update the state i.e. toogle the state of obscureText variable
                  model.togglePassword();
                },
              ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 2)),
          InkWell(
            // busy: model.isBusy,
            onTap: () {
              if (_signinFormPageKey.currentState.validate()) {
                //  model.signUp(
                //         _inputSignupNumberController.text,
                //         passwordController.text,
                //       );
                model.signIn(
                    '0' + int.parse(_inputSigninNumberController.text.splitMapJoin(' ', onMatch: (_) => '')).toString(),
                    _userPasswordController.text.trim());
              }
            },
            child: btnAuth(
                'Next',
                model.btnColor ? BrandColors.primary : ThemeColors.background,
                context),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 4)),
          Text(
            'or Continue with your social accounts',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF02034A),
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 1)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialIconButton(
                onTap: () {},
                socialIconUrl: 'assets/icons/google_icon.png',
              ),
              SocialIconButton(
                onTap: () {},
                socialIconUrl: 'assets/icons/facebook_icon.png',
              ),
              SocialIconButton(
                onTap: () {},
                socialIconUrl: 'assets/icons/apple_icon.png',
              ),
            ],
          ),
          SizedBox(height: SizeConfig.yMargin(context, 6)),
          InkWell(
            // busy: model.isBusy,
            onTap: () {
              model.navigateToSignup();
            },
            child: newBtnAuth(
                'Not a Member? Sign Up', ThemeColors.unselect, context),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 6)),
          Container(
              width: SizeConfig.xMargin(context, 60),
              child: CustomizeProgressIndicator(1, 4)),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
