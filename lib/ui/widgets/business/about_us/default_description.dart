part of '../../../views/business/about_us/about_my_customer_page/about_my_customer_view.dart';

class DescriptionTile extends ViewModelWidget<AboutMyCustomerViewModel> {
  DescriptionTile({
    Key key,
    this.items,
  }) : super(key: key, reactive: true);
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
          model.increment();
          pageController.animateToPage(
            model.currentAboutCustomerPayMe % items.length,
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
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
                          AnimatedContainer(
                            duration: new Duration(milliseconds: 300),
                            height: index * 2 ==
                                    (model.currentAboutCustomerPayMe %
                                        items.length)
                                ? SizeConfig.yMargin(context, 15)
                                : SizeConfig.yMargin(context, 12),
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
                              ? AnimatedContainer(
                                  duration: new Duration(milliseconds: 300),
                                  height: (index * 2) + 1 ==
                                          (model.currentAboutCustomerPayMe %
                                              items.length)
                                      ? SizeConfig.yMargin(context, 13)
                                      : SizeConfig.yMargin(context, 11),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: new Duration(milliseconds: 300),
                            height: (index * 2) ==
                                    (model.currentAboutCustomerPayMe %
                                        items.length)
                                ? (index - 1) % 4 == 0
                                    ? SizeConfig.yMargin(context, 16)
                                    : SizeConfig.yMargin(context, 10)
                                : (index - 1) % 4 != 0
                                    ? SizeConfig.yMargin(context, 16)
                                    : SizeConfig.yMargin(context, 10),
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
                          SizedBox(
                            height: SizeConfig.yMargin(context, 1),
                          ),
                          (index * 2) + 1 != items.length
                              ? AnimatedContainer(
                                  height: (index * 2) + 1 ==
                                          (model.currentAboutCustomerPayMe %
                                              items.length)
                                      ? (index - 1) % 4 == 0
                                          ? SizeConfig.yMargin(context, 16)
                                          : SizeConfig.yMargin(context, 10)
                                      : (index - 1) % 4 != 0
                                          ? SizeConfig.yMargin(context, 16)
                                          : SizeConfig.yMargin(context, 10),
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
                                  duration: new Duration(milliseconds: 300),
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
