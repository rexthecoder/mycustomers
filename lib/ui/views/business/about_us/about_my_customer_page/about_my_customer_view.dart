import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'about_my_customer_viewmodel.dart';

part '../../../../widgets/business/about_us/default_description.dart';

part '../../../../widgets/business/about_us/designer_description.dart';

class AboutMyCustomerView extends StatefulWidget {
  @override
  _AboutMyCustomerViewState createState() => _AboutMyCustomerViewState();
}

class _AboutMyCustomerViewState extends State<AboutMyCustomerView>
    with TickerProviderStateMixin {
  AnimationController _controllerCustomerPayMe;
  AnimationController _controllerMeetTheInvestors;
  AnimationController _controllerMeetTheDesigners;
  AnimationController _controllerMeetTheMobileTeam;
  AnimationController _controllerMeetTheWebTeam;
  final String myCustomerLogo = 'assets/icons/svg/customerpaymelogo.svg';

  @override
  void initState() {
    _controllerCustomerPayMe = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _controllerMeetTheInvestors = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _controllerMeetTheMobileTeam = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _controllerMeetTheWebTeam = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _controllerMeetTheDesigners = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controllerCustomerPayMe.dispose();
    _controllerMeetTheInvestors.dispose();
    _controllerMeetTheMobileTeam.dispose();
    _controllerMeetTheWebTeam.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutMyCustomerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(
          context,
          1.0,
          title: 'About CustomerPayMe',
          arrowColor: BrandColors.primary,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.yMargin(context, 2),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  myCustomerLogo,
                  height: SizeConfig.yMargin(context, 14),
                ),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 3),
              ),
              CardTile(
                text: 'About CustomerPayMe',
                func: model.changeOpenAboutCustomerPayMe,
                controller: _controllerCustomerPayMe,
                isOpen: model.isOpenAboutCustomerPayMe,
                items: AboutMyCustomerViewModel.aboutCustomerPay,
                type: 'CustomerPayMe',
              ),
              CardTile(
                text: 'Meet The Investors',
                func: model.changeOpenMeetTheInvestors,
                controller: _controllerMeetTheInvestors,
                isOpen: model.isOpenMeetTheInvestors,
//                itemsMap: model.investorsMap,
                items: AboutMyCustomerViewModel.investors,
                type: 'Web/Mobile/Investors',
              ),
              CardTile(
                text: 'Meet The Design Team',
                func: model.changeOpenMeetTheDesigner,
                controller: _controllerMeetTheDesigners,
                isOpen: model.isOpenMeetTheDesigners,
                type: 'Designer',
                items: AboutMyCustomerViewModel.designers,
              ),
              CardTile(
                text: 'Meet The Mobile Team',
                func: model.changeOpenMeetTheMobileTeam,
                controller: _controllerMeetTheMobileTeam,
                isOpen: model.isOpenMeetTheMobileTeam,
//                itemsMap: model.mobileMap,
                items: AboutMyCustomerViewModel.mobile,
//                type: 'Web/Mobile/Investors',
              ),
              CardTile(
                text: 'Meet The Web Team',
                func: model.changeOpenMeetTheWebTeam,
                controller: _controllerMeetTheWebTeam,
                isOpen: model.isOpenMeetTheWebTeam,
//                itemsMap: model.webMap,
                items: AboutMyCustomerViewModel.web,
                type: 'Designer',
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AboutMyCustomerViewModel(),
    );
  }
}

class CardTile extends ViewModelWidget<AboutMyCustomerViewModel> {
  CardTile({
    Key key,
    this.text,
    this.func,
    this.controller,
    this.isOpen,
    this.items,
    this.type,
  }) : super(key: key, reactive: true);

  final String text;
  final Function func;
  final AnimationController controller;
  final bool isOpen;
  final List<Person> items;
  final String type;

  @override
  Widget build(
    BuildContext context,
    AboutMyCustomerViewModel model,
  ) {
    return AnimatedContainer(
      height: isOpen
          ? SizeConfig.yMargin(context, 50)
          : SizeConfig.yMargin(context, 10),
      duration: new Duration(milliseconds: 300),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
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
              onTap: () {
                isOpen ? controller.reverse() : controller.forward();
                func();
              },
              title: Text(
                text,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: SizeConfig.yMargin(context, 2),
                      color: Theme.of(context).cursorColor,
                    ),
              ),
              trailing: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: controller,
              ),
            ),
          ),
          isOpen
              ? getDescription(
                  type: type,
                  items: items,
                )
              : Container(),
        ],
      ),
    );
  }
}

Widget getDescription({
  String type,
  List<Person> items,
}) {
  switch (type) {
    case 'Designer':
      return DesignersDescriptionTile(
        items: items,
      );
    case 'CustomerPayMe':
      return Container(
        child: Text(items[0].about),
      );
    case 'Web/Mobile/Investors':
      return DescriptionTile(
        items: items,
      );
    default:
      return Container();
  }
}
