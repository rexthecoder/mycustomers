import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/dot_pin_field.dart';
//import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'enter_pin_viewmodel.dart';

class EnterPinView extends StatelessWidget {
  final String myCustomerLogo = 'assets/icons/svg/my_customer_logo.svg';
  final TextEditingController enterOldPinCpontroller =
      new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: ViewModelBuilder<EnterPinViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 15)),
              child: AppBar(
                iconTheme: IconThemeData(color: ThemeColors.background),
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: BrandColors.primary,
                elevation: 0,
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 6)),
                  child: Expanded(
                    child: SvgPicture.asset(
                      myCustomerLogo,
                      color: Theme.of(context).appBarTheme.color,
                      height: SizeConfig.yMargin(context, 16),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: BrandColors.primary,
            body: PinField(
              title:  "Enter your pin to continue",
              textEditingController: enterOldPinCpontroller,
              onCompleted: (value) async {
                bool correct = await model.onOldPinCompleted(value);
                if (!correct) model.clearValueIfPinsDoNotMatch(enterOldPinCpontroller);
              },
            ),
          );
        },
        viewModelBuilder: () => EnterPinViewModel(),
      ),
    );
  }
}
