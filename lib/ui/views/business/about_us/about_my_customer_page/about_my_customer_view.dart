import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'about_my_customer_viewmodel.dart';

class AboutMyCustomerView extends StatefulWidget {
  @override
  _AboutMyCustomerViewState createState() => _AboutMyCustomerViewState();
}

class _AboutMyCustomerViewState extends State<AboutMyCustomerView>
    with TickerProviderStateMixin {
  AnimationController _controllerCustomerPayme;
  AnimationController _controllerMeetTheLeader;
  AnimationController _controllerMeetTheMobileTeam;
  AnimationController _controllerMeetTheWebTeam;
  final String myCustomerLogo = 'assets/icons/svg/customerpaymelogo.svg';

  @override
  void initState() {
    _controllerCustomerPayme = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _controllerMeetTheLeader = AnimationController(
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
    super.initState();
  }

  @override
  void dispose() {
    _controllerCustomerPayme.dispose();
    _controllerMeetTheLeader.dispose();
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
              CardTileText(
                text: 'About CustomerPayMe',
                func: model.changeOpenAboutCustomerPayMe,
                controller: _controllerCustomerPayme,
                isOpen: model.isOpenAboutCustomerPayMe,
              ),
              CardTile(
                text: 'Meet The Leaders',
                func: model.changeOpenMeetTheLeaders,
                controller: _controllerMeetTheLeader,
                isOpen: model.isOpenMeetTheLeaders,
                itemsMap: model.leaderMap,
                items: AboutMyCustomerViewModel.leader,
              ),
              CardTile(
                text: 'Meet The Mobile Team',
                func: model.changeOpenMeetTheMobileTeam,
                controller: _controllerMeetTheMobileTeam,
                isOpen: model.isOpenMeetTheMobileTeam,
                itemsMap: model.mobileMap,
                items: AboutMyCustomerViewModel.mobile,
              ),
              CardTile(
                text: 'Meet The Web Team',
                func: model.changeOpenMeetTheWebTeam,
                controller: _controllerMeetTheWebTeam,
                isOpen: model.isOpenMeetTheWebTeam,
                itemsMap: model.webMap,
                items: AboutMyCustomerViewModel.web,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AboutMyCustomerViewModel(),
      onModelReady: (model) => model.openDoc(),
    );
  }
}

class CardTileText extends ViewModelWidget<AboutMyCustomerViewModel> {
  CardTileText({
    Key key,
    this.text,
    this.func,
    this.controller,
    this.isOpen,
  }) : super(key: key, reactive: true);

  final String text;
  final Function func;
  final AnimationController controller;
  final bool isOpen;

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
              ? Container(
                  child: Text('About My Customer Pay me'),
                )
              : Container(),
        ],
      ),
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
    this.itemsMap,
  }) : super(key: key, reactive: true);

  final String text;
  final Function func;
  final AnimationController controller;
  final bool isOpen;
  final List<List<Person>> itemsMap;
  final List<Person> items;

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
              ? DescriptionTile(
                  items: items,
                  itemsMap: itemsMap,
                )
              : Container(),
        ],
      ),
    );
  }
}

class DescriptionTile extends ViewModelWidget<AboutMyCustomerViewModel> {
  DescriptionTile({
    Key key,
    this.items,
    this.itemsMap,
  }) : super(key: key, reactive: true);
  final List<List<Person>> itemsMap;
  final List<Person> items;

  @override
  Widget build(
    BuildContext context,
    AboutMyCustomerViewModel model,
  ) {
    ScrollController scrollController = ScrollController();
    PageController pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(new Duration(seconds: 5), (Timer timer) {
        if (pageController.hasClients) {
          pageController.animateToPage(
            model.currentAboutCustomerPayMe % 7,
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
          model.increment();
        }
      });
    });

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(context, 4),
          ),
          height: SizeConfig.yMargin(context, 30),
          child: ListView.builder(
            itemCount: itemsMap.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var item = itemsMap[index];
              return index % 2 == 0
                  ? Container(
                      width: SizeConfig.xMargin(context, 25),
                      child: InkWell(
//                        onTap: pageController.animateToPage(page, duration: null, curve: null),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(item[0].imageUrl),
//                        backgroundColor:
//                            (model.currentAboutCustomerPayMe % 7) % 3 == 0 &&
//                        (model.currentAboutCustomerPayMe % 7)  == 0
//                                    (index + (index / 2) + 0).floor() ==
//                                        (model.currentAboutCustomerPayMe % 7)
//                                ? ThemeColors.error
//                                : ThemeColors.black,
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: SizeConfig.xMargin(context, 25),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(item[0].imageUrl),
//                              backgroundColor:
//                                  (model.currentAboutCustomerPayMe % 7) % 3 ==
//                                              1 && index + 1 == (model.currentAboutCustomerPayMe % 7) +1
////                                          (index + (index / 2) + 1).floor() ==
////                                              (model.currentAboutCustomerPayMe %
////                                                  7)
//                                      ? ThemeColors.error
//                                      : ThemeColors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: SizeConfig.xMargin(context, 25),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(item[1].imageUrl),
//                              backgroundColor:
//                                  (model.currentAboutCustomerPayMe % 7) % 3 ==
//                                              2 && index + 2 == (model.currentAboutCustomerPayMe % 7) +2
////                                          (index + (index / 2) + 2).floor() ==
////                                              (model.currentAboutCustomerPayMe %
////                                                  7)
//                                      ? ThemeColors.error
//                                      : ThemeColors.black,
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
        Container(
          height: SizeConfig.yMargin(context, 10),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(context, 2),
          ),
          child: PageView.builder(
            physics: ClampingScrollPhysics(),
            allowImplicitScrolling: true,
            controller: pageController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: item.name,
                  style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 5),
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n${item.about}",
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
