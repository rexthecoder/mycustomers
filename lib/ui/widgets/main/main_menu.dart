part of '../../views/main/main_view.dart';

class MainMenu extends HookViewModelWidget<MainViewModel> {
  MainMenu({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return AnimatedPositioned(
      right: model.isCollapsed ? SizeConfig.xMargin(context, 100) : 0,
      top: 0,
      bottom: 0,
      left: model.isCollapsed ? SizeConfig.xMargin(context, -100) : 0,
      duration: model.duration,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < 0) {
            model.closeMenu();
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ThemeColors.black.withOpacity(0.7),
            body: Container(
              width: SizeConfig.xMargin(context, 80),
              color: ThemeColors.background,
              child: Row(
                children: <Widget>[
                  BusinessMenu(),
                  MenuOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
