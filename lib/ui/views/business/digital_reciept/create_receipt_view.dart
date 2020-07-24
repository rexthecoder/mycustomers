import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';

import 'create_receipt_viewmodel.dart';

class CreateReceiptView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateReceiptViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(
            context,
            1.0,
            children: [],
            title: 'Create a Receipt',
            arrowColor: BrandColors.primary,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                //TODO: BUILD HERE

                CustomRaisedButton(
                  txtColor: ThemeColors.background,
                  btnColor: BrandColors.primary,
                  btnText: 'Next',
                  borderColor: BrandColors.primary,
                  child: Container(),
                  onPressed: () {
                    // Leave the funtionality
                  },
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => CreateReceiptViewModel(),
    );
  }
}
