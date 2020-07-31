import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'about_us_viewmodel.dart';

class AboutUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutUsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(
          context,
          1.0,
          title: 'About Us',
          arrowColor: BrandColors.primary,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: Column(
            children: <Widget>[
              cardTile(
                'About CustomerPayMe',
                model.navigateToAboutMyCustomer,
                context,
              ),
              cardTile(
                'Privacy Policy',
                model.navigateToPrivacyPolicy,
                context,
              ),
              cardTile(
                'Terms & Conditions',
                model.navigateToTermsAndConditions,
                context,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AboutUsViewModel(),
    );
  }
}

Container cardTile(
  String text,
  Function func,
  BuildContext context,
) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: SizeConfig.yMargin(context, 1),
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).cursorColor.withOpacity(0.2),
        ),
      ),
    ),
    child: ListTile(
      onTap: func,
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: SizeConfig.yMargin(context, 2),
              color: Theme.of(context).cursorColor,
            ),
      ),
      trailing: SvgPicture.asset(
        'assets/icons/arrow_right.svg',
        color: Theme.of(context).cursorColor,
      ),
    ),
  );
}
