part of '../../views/main/main_view.dart';

class MainHeader extends HookViewModelWidget<MainViewModel> {
  MainHeader({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Container(
      color: BrandColors.primary,
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
        Expanded(
          child: SizedBox(),
        ),
        Container(
          child: Stack(
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
