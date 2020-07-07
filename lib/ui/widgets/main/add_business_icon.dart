part of '../../views/main/main_view.dart';

class AddBusinessIcon extends HookViewModelWidget<MainViewModel> {
  AddBusinessIcon({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: model.navigateToAddBusiness,
          child: Container(
            height: SizeConfig.xMargin(context, 18),
            width: SizeConfig.xMargin(context, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: ThemeColors.gray[600].withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0.3, 0.3)),
              ],
            ),
            padding: EdgeInsets.all(
              SizeConfig.yMargin(context, 0.7),
            ),
            child: GFAvatar(
              shape: GFAvatarShape.standard,
              backgroundColor: ThemeColors.background,
              child: Icon(
                Icons.add,
                color: ThemeColors.black,
                size: SizeConfig.textSize(context, 9),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Text(
          'Add Business',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 4),
          ),
        )
      ],
    );
  }
}
