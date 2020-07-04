import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'signin_viewmodel.dart';

class SignInView extends StatelessWidget {

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
        body: CustomBackground(child:  _PartialBuildForm()),
      ),
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}

class _PartialBuildForm extends HookViewModelWidget<SignInViewModel> {
  static final _signinFormPageKey = GlobalKey<FormState>();

  _PartialBuildForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, SignInViewModel viewModel) {
    
    var _inputSigninNumberController = useTextEditingController();
    var _userPasswordController = useTextEditingController();
    
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
                viewModel.number = number;
                // print('Phone changed');
              },
              // onInputValidated: (bool value) {
              //   viewModel.phoneValid = value;
              //   viewModel.activeBtn();
              //   print('Value is: $value');
              // },
              ignoreBlank: false,
              // autoValidate: true,
              // countries: ['NG', 'GH', 'BJ' 'TG', 'CI'],
              errorMessage: 'Invalid Phone Number',
              selectorType: PhoneInputSelectorType.DIALOG,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: viewModel.number,
              textFieldController: _inputSigninNumberController,
              // inputBorder: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: TextFormField(
              key: Key("userpassword"),
              controller: _userPasswordController,
              obscureText: viewModel.obscureText,
              // viewModel.obscureText,
              validator: (_) => viewModel.validatePassword(_userPasswordController.text),
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: SizeConfig.yMargin(context, 2),
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              // autovalidate: true,
              // onChanged: (_) {
              //   viewModel.validatePassword(_userPassword.text);
              //   viewModel.activeBtn();
              // },
              decoration: InputDecoration(
                // suffixIcon: _CustomPartialBuildWidget<SignUpViewModel>(
                //   builder: (BuildContext context, SignUpViewModel viewModel) =>
                //       IconButton(
                //     icon: Icon(
                //       // Based on obscureText state choose the icon
                //       viewModel.obscureText
                //           ? Icons.visibility
                //           : Icons.visibility_off,
                //       color: Theme.of(context).primaryColorDark,
                //     ),
                //     onPressed: () {
                //       // Update the state i.e. toogle the state of obscureText variable
                //       viewModel.togglePassword();
                //     },
                //   ),
                // ),
                labelText: "Password",
                // border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 2)),
          InkWell(
            onTap: () {
              if (!_signinFormPageKey.currentState.validate()) return;
              viewModel.signIn(
                '0' +
                    int.parse(_inputSigninNumberController.text
                        .splitMapJoin(' ', onMatch: (_) => '')).toString(),
                _userPasswordController.text.trim(),
              );
            },
            child: _CustomPartialBuildWidget<SignInViewModel>(
              builder: (BuildContext context, SignInViewModel viewModel) =>
                  btnAuth(
                      'Next',
                      // viewModel.btnColor ?
                      BrandColors.primary,
                      // : ThemeColors.gray.shade700,
                      context),
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
              viewModel.navigateToSignup();
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

class _CustomPartialBuildWidget<T extends BaseViewModel>
    extends HookViewModelWidget<T> {
  final Function(BuildContext, T) builder;

  _CustomPartialBuildWidget(
      {Key key, @required this.builder, bool reactive: true})
      : super(key: key, reactive: reactive);
  @override
  Widget buildViewModelWidget(BuildContext context, T viewModel) {
    return this.builder(context, viewModel);
  }
}
