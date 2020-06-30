import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget{
  TextEditingController _inputSignupNumberController = TextEditingController();
  static final _signupFormPageKey = GlobalKey<FormState>();
  final _signupPageKey = GlobalKey<ScaffoldState>();
  bool busy;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        key: _signupPageKey,
        body: HomeBackgroundWidget(
          height: height,
          width: width,
          child: Form(
            key: _signupFormPageKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.yMargin(context, 3)),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 4),
                  ),
                ),
                SizedBox(height: SizeConfig.xMargin(context, 6)),
                Text(
                  'Please Enter your Phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.yMargin(context, 2),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 2)),
                Container(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 0.2)),
                  height: SizeConfig.yMargin(context, 14),
                  width: SizeConfig.xMargin(context, 90),
                  // decoration: BoxDecoration(
                  //     border: Border.all(width: 2, color: Colors.grey),
                  //     borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      //TODO:
                    },
                    onInputValidated: (bool value) {
                      //TODO: Validation
                    },
                    ignoreBlank: false,
                    autoValidate: false,
                    errorMessage: 'Invalid Phone Number',
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: model.number,
                    textFieldController: _inputSignupNumberController,
                    inputBorder: OutlineInputBorder(),
                  ),
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
                SizedBox(height: SizeConfig.yMargin(context, 3)),
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
                SizedBox(height: SizeConfig.yMargin(context, 2)),
                InkWell(
                        // busy: model.isBusy,
                    onTap: () {
                      if (_signupFormPageKey.currentState.validate()) {
                    //  model.signUp(
                    //         _inputSignupNumberController.text,
                    //         passwordController.text,
                    //       );
                      }
                    },
                    child: btnAuth('Next', context)),
                SizedBox(height: SizeConfig.yMargin(context, 3)),
                Container(
                  // height: SizeConfig.yMargin(context, 10),
                  width: SizeConfig.xMargin(context, 90),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Color(0xFF2F80ED),
                          fontSize: SizeConfig.yMargin(context, 2),
                        ),
                      ),
                      SizedBox(width: SizeConfig.xMargin(context, 1)),
                      InkWell(
                        onTap: () {
                          model.navigateToLogin();
                        },
                        child: Text(
                          'SignIn',
                          style: TextStyle(
                            color: Color(0xFF2F80ED),
                            fontSize: SizeConfig.yMargin(context, 2),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 14)),
                Container(
                    width: SizeConfig.xMargin(context, 60),
                    child: CustomizeProgressIndicator(2, 4)),
                SizedBox(height: SizeConfig.yMargin(context, 6)),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
