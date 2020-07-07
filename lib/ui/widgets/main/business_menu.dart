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
        minWidth: SizeConfig.xMargin(context, 23),
        maxWidth: SizeConfig.xMargin(context, 24),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 2),
      ),
      color: ThemeColors.gray[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BusinessMenuOptions(),
          Divider(color: ThemeColors.gray[700]),
          AddBusinessIcon(),
        ],
      ),
    );
  }
}
