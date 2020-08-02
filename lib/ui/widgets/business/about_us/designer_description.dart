part of '../../../views/business/about_us/about_my_customer_page/about_my_customer_view.dart';

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
              return AnimatedContainer(
                decoration: BoxDecoration(
                  color: ThemeColors.error,
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                height:
                    index == (model.currentAboutCustomerPayMe % items.length)
                        ? SizeConfig.yMargin(context, 26)
                        : SizeConfig.yMargin(context, 20),
                width: index == (model.currentAboutCustomerPayMe % items.length)
                    ? SizeConfig.xMargin(context, 31)
                    : SizeConfig.xMargin(context, 28),
                duration: new Duration(milliseconds: 300),
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
