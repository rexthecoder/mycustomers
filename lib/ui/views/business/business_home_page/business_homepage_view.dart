import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/core/models/business_model.dart';

import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xff333cc1),
                  height: SizeConfig.yMargin(context, 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: SizeConfig.yMargin(context, -12.0),
                        left: SizeConfig.yMargin(context, -10.0),
                        child: circleDesign(SizeConfig.yMargin(context, 10),
                            SizeConfig.yMargin(context, 7)),
                      ),
                      Positioned(
                        top: SizeConfig.yMargin(context, -12.0),
                        right: SizeConfig.yMargin(context, -12.0),
                        child: circleDesign(SizeConfig.yMargin(context, 10),
                            SizeConfig.yMargin(context, 7)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.yMargin(context, 3)),
                        child: _HeaderBar(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: SizeConfig.yMargin(context, 11),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  child: ListTile(
                    subtitle: Text(
                      'Your name',
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3.4),
                      ),
                    ),
                    title: Text(
                      'Cynthia Ike',
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF333CC1),
                      minRadius: SizeConfig.xMargin(context, 7),
                      maxRadius: SizeConfig.xMargin(context, 8),
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.textSize(context, 9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: FlatButton(
                      color: const Color(0xFFE8FFF5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: model.navigateToProfilePage,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: const Color(0xFF21D184),
                          fontSize: SizeConfig.textSize(context, 3.5),
                        ),
                      ),
                    ),
                  ),
                ),
                optionButton(
                  context: context,
                  icon: businessCard,
                  label: 'Business Card',
                  onTap: model.navigateToBusinessCardPage,
                ),
                optionButton(
                  context: context,
                  icon: settings,
                  label: 'Settings',
                  onTap: model.navigateToSettingsPage,
                ),
                optionButton(
                  context: context,
                  icon: support,
                  label: 'Support',
                  onTap: model.navigateToSupportPage,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }

  Container optionButton(
      {BuildContext context, String label, Function onTap, String icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFFFFFF),
          minRadius: SizeConfig.xMargin(context, 4),
          maxRadius: SizeConfig.xMargin(context, 6),
          child: SvgPicture.asset(
            icon,
            semanticsLabel: label,
            color: const Color(0xFF333CC1),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: const Color(0xFF000000),
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BusinessSelector(),
        Expanded(
          child: SizedBox(),
        ),
        Container(
          child: Stack(
            //  alignment: Alignment.topRight,
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
            ],
            overflow: Overflow.clip,
          ),
        ),
      ],
    );
  }
}

class BusinessSelector extends HookViewModelWidget<BusinessHomePageViewModel> {
  BusinessSelector({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
          BuildContext context, BusinessHomePageViewModel model) =>
      Container(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Business>(
            dropdownColor: Colors.black,
            value: model.selectedBusiness,
            items: Business.business.map((business) {
              return DropdownMenuItem<Business>(
                value: business,
                child: Text(
                  business.businessName,
                  style: TextStyle(
                    fontSize: SizeConfig.yMargin(context, 2),
                    color: ThemeColors.background,
                    fontWeight: FontWeight.w900,
                    //     color: Colors.blueAccent,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              model.changeBusiness(value);
            },
          ),
        ),
      );
}
