part of '../../views/main/main_view.dart';

class BusinessMenuOptions extends HookViewModelWidget<MainViewModel> {
  BusinessMenuOptions({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: SizeConfig.yMargin(context, 65),
      ),
      child: model.stores == null
          ? Container()
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: model.stores.length,
              itemBuilder: (context, index) => businessIcon(
                context,
                model.stores[index],
                model,
              ),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: SizeConfig.yMargin(context, 2),
              ),
            ),
    );
  }

  Widget businessIcon(
      BuildContext context, Store business, MainViewModel model) {
    return BoxButton(
      label: business.name,
      child: Text(
        business.name.substring(0, 1),
        style: TextStyle(
          color: ThemeColors.black,
          fontSize: SizeConfig.textSize(context, 12),
          fontWeight: FontWeight.bold,
        ),
      ),
      highLight: model.currStore.id == business.id,
      onTap: () {
        // TODO: Add fetch store details
        model.changeBusiness(business.id);
      },
    );
  }
}

class AddBusinessIcon extends HookViewModelWidget<MainViewModel> {
  AddBusinessIcon({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return BoxButton(
      label: 'Add Business',
      onTap: model.navigateToAddBusiness,
      highLight: false,
      child: Icon(
        Icons.add,
        color: ThemeColors.black,
        size: SizeConfig.textSize(context, 9),
      ),
    );
  }
}

class BoxButton extends HookViewModelWidget<MainViewModel> {
  final String label;
  final Widget child;
  final Function onTap;
  final bool highLight;

  BoxButton({this.label, this.child, this.onTap, this.highLight});

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
//    bool isSelected = model.currStore.id == business.id;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.xMargin(context, 18),
            width: SizeConfig.xMargin(context, 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: highLight ? BrandColors.primary : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.gray[600].withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0.3, 0.3),
                  ),
                ]),
            padding: EdgeInsets.all(
              SizeConfig.yMargin(context, 0.7),
            ),
            child: GFAvatar(
              shape: GFAvatarShape.standard,
              backgroundColor: ThemeColors.background,
              child: child,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Text(
            label,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SizeConfig.textSize(context, 3),
            ),
          )
        ],
      ),
    );
  }
}
