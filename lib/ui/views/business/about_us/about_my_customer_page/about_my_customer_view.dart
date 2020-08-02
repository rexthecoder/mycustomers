import 'dart:async';
import 'dart:math';

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
                type: 'Web/Mobile/Investors',
              ),
              CardTile(
                text: 'Meet The Web Team',
                func: model.changeOpenMeetTheWebTeam,
                controller: _controllerMeetTheWebTeam,
                isOpen: model.isOpenMeetTheWebTeam,
//                itemsMap: model.webMap,
                items: AboutMyCustomerViewModel.web,
                type: 'Web/Mobile/Investors',
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
    this.itemsMap,
    this.type,
  }) : super(key: key, reactive: true);

  final String text;
  final Function func;
  final AnimationController controller;
  final bool isOpen;
  final List<List<Person>> itemsMap;
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
            vertical: SizeConfig.yMargin(context, 1),
            horizontal: SizeConfig.xMargin(context, 4),
          ),
          height: SizeConfig.yMargin(context, 30),
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: (items.length / 2).floor() + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return index % 2 == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: SizeConfig.yMargin(context, 12),
                            width: SizeConfig.xMargin(context, 25),
                            decoration: BoxDecoration(
                              color: ThemeColors.black,
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(items[index * 2].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          (index * 2) + 1 != items.length
                              ? Container(
                                  height: SizeConfig.yMargin(context, 12),
                                  width: SizeConfig.xMargin(context, 25),
                                  decoration: BoxDecoration(
                                    color: ThemeColors.error,
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          items[(index * 2) + 1].imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Expanded(
                            flex: (index - 1) % 4 != 0 ? 2 : 1,
                            child: Container(
                              height: SizeConfig.yMargin(context, 10),
                              width: SizeConfig.xMargin(context, 25),
                              decoration: BoxDecoration(
                                color: ThemeColors.error,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage(items[index * 2].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.yMargin(context, 1),
                          ),
                          (index * 2) + 1 != items.length
                              ? Expanded(
                                  flex: (index - 1) % 4 == 0 ? 2 : 1,
                                  child: Container(
                                    height: SizeConfig.yMargin(context, 10),
                                    width: SizeConfig.xMargin(context, 25),
                                    decoration: BoxDecoration(
                                      color: ThemeColors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            items[(index * 2) + 1].imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: SizeConfig.xMargin(context, 2),
              ),
            ),
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

class DesignersDescriptionTile
    extends ViewModelWidget<AboutMyCustomerViewModel> {
  DesignersDescriptionTile({
    Key key,
    this.items,
  }) : super(key: key, reactive: true);
  final List<Person> items;

  @override
  Widget build(
    BuildContext context,
    AboutMyCustomerViewModel model,
  ) {
    PageController pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(new Duration(seconds: 5), (Timer timer) {
        if (pageController.hasClients) {
          pageController.animateToPage(
            model.currentMeetTheDesignTeam % items.length,
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
          model.increment();
        }
      });
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(context, 4),
          ),
          height: SizeConfig.yMargin(context, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(items.length, (index) {
              var item = items[index];
              return index % 2 == 0
                  ? AnimatedContainer(
                      decoration: BoxDecoration(
                        color: ThemeColors.error,
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: index == model.currentMeetTheDesignTeam ? SizeConfig.yMargin(context, 21): SizeConfig.yMargin(context, 20),
                      width: index == model.currentMeetTheDesignTeam ? SizeConfig.xMargin(context, 31) : SizeConfig.xMargin(context, 30),
                      duration: new Duration(milliseconds: 300),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.black,
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                height: index == model.currentAboutCustomerPayMe ? SizeConfig.yMargin(context, 26): SizeConfig.yMargin(context, 25),
                width: index == model.currentAboutCustomerPayMe ? SizeConfig.xMargin(context, 31) : SizeConfig.xMargin(context, 30),
                    );
            }),
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

Widget getDescription({
  String type,
  List<List<Person>> itemsMap,
  List<Person> items,
}) {
  switch (type) {
    case 'Designer':
      return DesignersDescriptionTile(
        items: items,
      );
    case 'CustomerPayMe':
      return Container(
        child: Text('About My Customer'),
      );
    case 'Web/Mobile/Investors':
      return DescriptionTile(
        items: items,
        itemsMap: itemsMap,
      );
    default:
      return Container();
  }
}
