import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/animation/fade_in.dart';
import 'package:mycustomers/ui/widgets/shared/dot_pin_field.dart';
import 'package:mycustomers/ui/widgets/stateful/lazy_index_stacked.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'change_pin_settings_page_viewmodel.dart';

class ChangePinSettingsPageView extends StatelessWidget {
  final String myCustomerLogo = 'assets/icons/svg/my_customer_logo.svg';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720);
    TextEditingController createPinController =
        new TextEditingController(text: "");
    TextEditingController confirmPinController =
        new TextEditingController(text: "");

    return ViewModelBuilder<ChangePinSettingsPageViewModel>.reactive(
      viewModelBuilder: () => ChangePinSettingsPageViewModel(),
      builder: (context, model, child) {
        final _views = <Widget>[
          FadeIn(
            child: PinField(
              title: 'Create a New PIN',
              textEditingController: createPinController,
              onCompleted: (value) => model.onCreatePinCompleted(value),
            ),
          ),
          FadeIn(
            child: PinField(
              title: 'Confirm New PIN',
              textEditingController: confirmPinController,
              onCompleted: (value) => model.onConfirmPinCompleted(value),
            ),
          ),
        ];

        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 20)),
              child: AppBar(
                iconTheme: IconThemeData(color: ThemeColors.background),
                centerTitle: true,
                backgroundColor: BrandColors.primary,
                elevation: 0,
                flexibleSpace: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.yMargin(context, 2)),
                  child: SvgPicture.asset(
                    myCustomerLogo,
                    color: Theme.of(context).appBarTheme.color,
                    height: SizeConfig.yMargin(context, 25),
                  ),
                ),
              ),
            ),
            backgroundColor: BrandColors.primary,
            body: LazyIndexedStack(
              reuse: true,
              index: model.index,
              itemCount: _views.length,
              itemBuilder: (_, index) => _views[index],
            ),
          ),
        );
      },
    );
  }
}
