import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'phone_viewmodel.dart';
import '../../../core/mixings/validators.dart';
import '../../widgets/shared/custom_raised_button.dart';
import '../../widgets/shared/social_icon.dart';

class PhoneView extends StatelessWidget with Validators {
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
    return ViewModelBuilder<PhoneViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: ScreenUtil.screenHeightDp * 0.6,
            width: ScreenUtil.screenWidthDp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/auth_background.png'),
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
          height: ScreenUtil.screenHeightDp * 0.4,
          width: ScreenUtil.screenWidthDp,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Please, Enter your Phone number',
                style: regularTextStyle,
              ),
              mediumVerticalHeight,
              IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: model.dropdownValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 16,
                        elevation: 16,
                        style: regularTextStyle,
                        onChanged: model.setDropdownValue,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        items:
                            model.dropdownItems.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(value),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: validatePhoneNumber,
                          onFieldSubmitted: (String value) {},
                          onSaved: (String value) {},
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              mediumVerticalHeight,
              Text(
                'Or Continue with your social account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              smallVerticalHeight,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIconButton(
                      onTap: () {},
                      socialIconUrl: 'assets/images/google_icon.png',
                    ),
                    SocialIconButton(
                      onTap: () {},
                      socialIconUrl: 'assets/images/facebook_icon.png',
                    ),
                    SocialIconButton(
                      onTap: () {},
                      socialIconUrl: 'assets/images/apple_icon.png',
                    ),
                  ],
                ),
              ),
              smallVerticalHeight,
              CustomRaisedButton(
                label: 'Next',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PhoneViewModel(),
    );
  }
}
