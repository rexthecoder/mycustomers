import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:mycustomers/core/localization/app_localization.dart';

import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'package:mycustomers/ui/views/business/settings/language_settings/language_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/partial_build.dart';

import 'package:stacked/stacked.dart';
import 'package:worm_indicator/indicator.dart';
import 'package:worm_indicator/shape.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PageView(
                  physics: ClampingScrollPhysics(),
                  controller: model.pageController,
                  onPageChanged: model.restartTimer,
                  children: [
                    _Pages(
                      'assets/images/onboarding/onboarding1.png',
                      AppLocalizations.of(context).onboardingWelcomeText,
                      AppLocalizations.of(context).onboardingWelcomeDesc,
                    ),
                    _Pages(
                      'assets/images/onboarding/onboarding2.png',
                      AppLocalizations.of(context).pushAReminder,
                      AppLocalizations.of(context).pushAReminderDesc,
                    ),
                    _Pages(
                      'assets/images/onboarding/onboarding3.png',
                      AppLocalizations.of(context).collectYourMoney,
                      AppLocalizations.of(context).collectYourMoneyDesc,
                    ),
                    _Pages(
                      'assets/images/onboarding/onboarding4.png',
                      AppLocalizations.of(context).engagedWithYourPeople,
                      AppLocalizations.of(context).engagedWithYourPeopleDesc,
                    ),
                  ],
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 24),
                  left: 0,
                  right: 0,
                  child: WormIndicator(
                    indicatorColor: BrandColors.primary,
                    color: ThemeColors.gray.shade800,
                    length: 4,
                    controller: model.pageController,
                    shape: Shape(
                      size: SizeConfig.yMargin(context, 0.8),
                      shape: DotShape.Circle,
                      spacing: SizeConfig.xMargin(context, 3),
                    ),
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 15),
                  child: CustomRaisedButton(
                    txtColor: ThemeColors.background,
                    btnColor: BrandColors.primary,
                    btnText: AppLocalizations.of(context).getStartedButton,
                    borderColor: BrandColors.primary,
                    child: Container(),
                    onPressed: () {
                      model.navigateToSignUp();
                    },
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 8),
                  child: CustomRaisedButton(
                    txtColor: BrandColors.primary,
                    btnColor: ThemeColors.background,
                    btnText: AppLocalizations.of(context).signIn,
                    borderColor: BrandColors.primary,
                    child: Container(),
                    onPressed: () {
                      model.navigateToSignIn();
                    },
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 0),
                  child: ViewModelBuilder<LanguageViewModel>.reactive(
                    builder: (context, model, child) =>
                        CustomPartialBuild<SettingManagerModel>(
                      builder: (context, viewModel) => FlatButton(
                        onPressed: () =>
                            openLanguageOptions(context, viewModel, model),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: viewModel.selectedLanguage,
                            style: TextStyle(
                              fontSize: SizeConfig.textSize(context, 3),
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).cursorColor,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' - ${AppLocalizations.of(context).changeLanguage}',
                                style: TextStyle(
                                  fontSize: SizeConfig.textSize(context, 3),
                                  color: Theme.of(context).cursorColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    viewModelBuilder: () => LanguageViewModel(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
      onModelReady: (model) => model.initState(),
    );
  }

  openLanguageOptions(
    BuildContext context,
    SettingManagerModel viewModel,
    LanguageViewModel model,
  ) {
    showModalBottomSheet(
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.xMargin(context, 8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.yMargin(context, 3),
            ),
            Text(
              AppLocalizations.of(context).selectYourLanguage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.yMargin(context, 2.2),
              ),
            ),
            SizedBox(
              height: SizeConfig.yMargin(context, 2),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.yMargin(context, 0.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        viewModel.setLocale(model.languages[index]['code'],
                            model.languages[index]['name']);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: SizeConfig.yMargin(context, 7),
                        width: SizeConfig.xMargin(context, 100),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(13, 71, 126, 200),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: (viewModel.locale?.languageCode ??
                                        Localizations.localeOf(context)
                                            .languageCode) ==
                                    model.languages[index]['code']
                                ? Theme.of(context).textSelectionColor
                                : Color(0xFFE8E8E8),
                          ),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(
                                  SizeConfig.yMargin(context, 1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.yMargin(context, 5)),
                                child: Image(
                                  height: SizeConfig.yMargin(context, 10),
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    model.languages[index]['image'],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              model.languages[index]['name'],
                              style: TextStyle(
                                color: Theme.of(context).cursorColor,
                                fontSize: SizeConfig.yMargin(context, 2.5),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.yMargin(context, 4)),
                                child: Text("")),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: model.languages.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  final String img1;
  final String txt1;
  final String txt2;

  const _Pages(this.img1, this.txt1, this.txt2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(35),
          child: ClipRect(
            child: Image(
              height: SizeConfig.yMargin(context, 45),
              image: AssetImage(img1),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 3)),
        Text(
          txt1,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 5),
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 1.2)),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.xMargin(context, 4),
              right: SizeConfig.xMargin(context, 4)),
          child: Text(
            txt2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.textSize(context, 4),
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
