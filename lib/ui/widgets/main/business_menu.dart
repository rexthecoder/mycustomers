part of '../../views/main/main_view.dart';

class BusinessMenu extends HookViewModelWidget<MainViewModel> {
  BusinessMenu({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Container(
      constraints: BoxConstraints(
        minWidth: SizeConfig.xMargin(context, 25),
        maxWidth: SizeConfig.xMargin(context, 25),
      ),
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BusinessMenuOptions(),
          Divider(color: ThemeColors.gray[700]),
          AddBusinessIcon(),
          FlatButton(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.xMargin(context, 3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.first_page,
                  size: SizeConfig.textSize(context, 5),
                ),
                Expanded(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => model.signOut,
          ),
        ],
      ),
    );
  }
}
