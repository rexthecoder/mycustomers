import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/mixings/validators.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget with Validators {

  TextEditingController _inputNumberController = TextEditingController();
  final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
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
                  'SIGN UP',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 4),
                  ),
                ),
                SizedBox(height: SizeConfig.xMargin(context, 4)),
                Text(
                  'Please Enter your Phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.yMargin(context, 2),
                  ),
                ),
                // SizedBox(height: SizeConfig.yMargin(context, 0.2)),
                // Container(
                //     height: SizeConfig.yMargin(context, 60),
                //     width: SizeConfig.xMargin(context, 90),

                // ),
                SizedBox(height: SizeConfig.yMargin(context, 5)),
                Padding(
                  padding: EdgeInsets.all(
                    SizeConfig.yMargin(context, 0.8),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Expanded(
                      //   flex: 1,
                      //   child: DropdownButton<String>(
                      //     value: model.dropdownValue,
                      //     icon: Icon(Icons.keyboard_arrow_down),
                      //     iconSize: 25.w,
                      //     elevation: 16,
                      //     onChanged: (String data) {
                      //       model.setDropdownValue(data);
                      //     },
                      //     items: model.dropdownItems
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      // Container(
                      //   width: SizeConfig.xMargin(context, 10),
                      //   color: Colors.black,
                      // ),
                      Expanded(
                        child: TextFormField(
                          key: Key('num'),
                          controller: _inputNumberController,
                          validator: (value) => (value.isEmpty)
                              ? "Please Enter Phone Number"
                              : null,
                          style:
                              TextStyle(fontFamily: 'Roboto', fontSize: 20.0),
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 3)),
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
                    onTap: () {
                      model.navigateToNextScreen();
                    },
                    child: btnAuth('Next', context)),
                SizedBox(height: SizeConfig.yMargin(context, 2)),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 4)),
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
                          'Login',
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
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
