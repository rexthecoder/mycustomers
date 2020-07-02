import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget {
  static final _signupFormPageKey = GlobalKey<FormState>();
  final _signupPageKey = GlobalKey<ScaffoldState>();

  TextEditingController _inputSignupNumberController;
  TextEditingController _userPassword;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        key: _signupPageKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: BrandColors.primary,
        body: CustomBackground(child: buildForm(context, model)),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }

  Widget buildForm(BuildContext context, SignUpViewModel model) {
    return Form(
      key: _signupFormPageKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.yMargin(context, 3)),
          Text(
            'SIGN UP',
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
              textFieldController: _inputSignupNumberController,
              // inputBorder: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: TextFormField(
              key: Key("userpassword"),
              controller: _userPassword,
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
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on obsecureText state choose the icon
                    model.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of obscureText variable
                    model.togglePassword();
                  },
                ),
                labelText: "Password",
                // border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 2)),
          InkWell(
            // busy: model.isBusy,
            onTap: () {
              if (_signupFormPageKey.currentState.validate()) {
                //  model.signUp(
                //         _inputSignupNumberController.text,
                //         passwordController.text,
                //       );
                model.navigateToNextScreen();
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
                model.navigateToLogin();
              },
              child: newBtnAuth(
                  'Already a Member? Sign In', ThemeColors.unselect, context),
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

