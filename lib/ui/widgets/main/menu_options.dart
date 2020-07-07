part of '../../views/main/main_view.dart';


class MenuOptions extends HookViewModelWidget<MainViewModel> {
  MenuOptions({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context,
      MainViewModel model,
      ) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.xMargin(context, 5),
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Wearsmute',
                  style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 6),
                      color: ThemeColors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '\nFashion Wears',
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3),
                        color: ThemeColors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: ThemeColors.gray[700],
            ),
            buildMenuList(context, model.menus),
            Divider(
              color: ThemeColors.gray[700],
            ),
            buildMenuList(context, model.settings),
            Divider(
              color: ThemeColors.gray[700],
            ),
            buildMenuList(context, model.signOut),
          ],
        ),
      ),
    );
  }

  Widget buildMenuList(BuildContext context, List list) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.xMargin(context, 5),
      ),
      child: Column(
        children: <Widget>[
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var menu = list[index];
              return sideBarMenuButton(
                context: context,
                label: menu.label,
                active: false,
                icon: menu.icon,
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: SizeConfig.xMargin(context, 5),
            ),
            itemCount: list.length,
          ),
          SizedBox(
            height: SizeConfig.xMargin(context, 3),
          ),
        ],
      ),
    );
  }

  Widget sideBarMenuButton({
    BuildContext context,
    String label,
    Function onTap,
    bool active,
    String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            icon,
            color: active ? BrandColors.primary : ThemeColors.black,
            semanticsLabel: label,
            height: SizeConfig.xMargin(context, 6),
            width: SizeConfig.xMargin(context, 6),
          ),
          SizedBox(
            width: SizeConfig.textSize(context, 3),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: SizeConfig.textSize(context, 4.5),
              color: active ? BrandColors.primary : ThemeColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
