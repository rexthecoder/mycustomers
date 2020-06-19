import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'signup_viewmodel.dart';


class SignUpView extends StatelessWidget {

  List<Widget> pages = [
    Name(),
    Company()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: false);
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
          child: PlatformScaffold(
            body: model.page == 0 ? Name(model: model,) : Company(model: model,)
          )
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}

class _UserForm extends HookViewModelWidget<SignUpViewModel> {
  _UserForm() : super(reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, SignUpViewModel viewModel) {
    var text = useTextEditingController();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey[300], borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: text,
        onChanged: viewModel.updateName,
        maxLines: null,
        maxLengthEnforced: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 10),
            height: 105.h,
            width: 1.0,
            color: Color(0xFFDADADA),
          ),
          prefixIconConstraints: BoxConstraints(maxWidth: 20),
          hintText: 'Enter Your Name',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300]
        ),
      ),
    );
  }
}

class _CompanyForm extends HookViewModelWidget<SignUpViewModel> {
  _CompanyForm() : super(reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, SignUpViewModel viewModel) {
    var text = useTextEditingController();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey[300], borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: text,
        onChanged: viewModel.updateCompany,
        maxLines: null,
        maxLengthEnforced: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 10),
            height: 105.h,
            width: 1.0,
            color: Color(0xFFDADADA),
          ),
          prefixIconConstraints: BoxConstraints(maxWidth: 20),
          hintText: 'Enter company name',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300]
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  final SignUpViewModel model;

  const Name({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: 1080.w,
        height: 1920.h,
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(1920*0.67),
                    child: Image.asset(
                      'assets/images/backg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(1920*0.67),
                    color: Colors.black.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Text(
                        'We\'d like to Know you',
                        style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(150, allowFontScalingSelf: true), color: Color(0xFFFDA741), fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'What\'s Your Name',
                      style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(70, allowFontScalingSelf: true), fontWeight: FontWeight.w400),
                    ),
                    _UserForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 160.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF000E66),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: null
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: model.updatePage,
                          child: Container(
                            width: 600.h,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF333CC1),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Finish',
                                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(60, allowFontScalingSelf: true), color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Company extends StatelessWidget {

  final SignUpViewModel model;

  const Company({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: 1080.w,
        height: 1920.h,
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(1920*0.67),
                    child: Image.asset(
                      'assets/images/backg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(1080),
                    height: ScreenUtil().setHeight(1920*0.67),
                    color: Colors.black.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Text(
                        'Last Step, I promise',
                        style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(150, allowFontScalingSelf: true), color: Color(0xFFF333CC1), fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'What\'s The Name Of Your Company',
                      style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(70, allowFontScalingSelf: true), fontWeight: FontWeight.w400),
                    ),
                    _CompanyForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: model.updatePage,
                          child: Container(
                            width: 160.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF000E66),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: null
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 600.h,
                          height: 120.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF333CC1),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Finish',
                                  style: Theme.of(context).textTheme.headline5.copyWith(fontSize: ScreenUtil().setSp(60, allowFontScalingSelf: true), color: Colors.white, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}