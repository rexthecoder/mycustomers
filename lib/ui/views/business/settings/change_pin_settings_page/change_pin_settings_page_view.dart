import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    return ViewModelBuilder<ChangePinSettingsPageViewModel>.reactive(
      viewModelBuilder: () => ChangePinSettingsPageViewModel(),
      builder: (context, model, child) {
        final _views = <Widget>[
          FadeIn(
            child: PinField(
              title: 'Create a New PIN',
//              validator: (String value) {},
//              onSubmitted: (String value) {},
//              onChange: (String value) {},
              onCompleted: (value) => model.onCreatePinCompleted(value),
            ),
          ),
          FadeIn(
            child: PinField(
              title: 'Confirm New PIN',
//              validator: (String value) {},
//              onSubmitted: (String value) {},
//              onChange: (String value) {},
              onCompleted: (value) => model.onConfirmPinCompleted(value),
            ),
          ),
        ];

        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 20)),
              child: AppBar(
                centerTitle: true,
                backgroundColor: const Color(0xFF333CC1),
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
            backgroundColor: const Color(0xFF333CC1),
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
