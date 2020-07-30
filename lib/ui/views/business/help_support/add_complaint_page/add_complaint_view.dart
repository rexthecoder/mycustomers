import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'add_complaint_viewmodel.dart';

class AddComplaintView extends StatelessWidget {
  final TextEditingController k = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
    return ViewModelBuilder<AddComplaintViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customizeAppBar(context, 1.0,
            children: [],
            // TODO Localize
            title: 'Add Complaint',
            arrowColor: BrandColors.primary,
            backgroundColor: Theme.of(context).backgroundColor),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.xMargin(context, 4),
              vertical: SizeConfig.yMargin(context, 2),
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => model.validateFields(value),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => model.onChangeSubject(value),
                  decoration: InputDecoration(
                    // TODO Localize subject
                    hintText: 'Subject',
                    hintStyle: TextStyle(fontSize: 16.sp),
                    contentPadding: EdgeInsets.fromLTRB(16.h, 20, 0, 16.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Color(0xffd1d1d1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 2),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => model.validateFields(value),
                  onChanged: (value) => model.onChangeMessage(value),
                  minLines: 8,
                  maxLines: 12,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).message,
                    hintStyle: TextStyle(fontSize: 16.sp),
                    contentPadding: EdgeInsets.fromLTRB(16.h, 20, 0, 16.h),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5),
                      borderSide: new BorderSide(
                        color: Color(0xffd1d1d1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                ),
                CustomRaisedButton(
                  txtColor: ThemeColors.background,
                  btnColor: BrandColors.primary,
                  btnText: AppLocalizations.of(context).send,
                  borderColor: BrandColors.primary,
                  child: Container(),
                  onPressed: () {
                    model.sendComplaint();
                    FlushbarHelper.createInformation(
                      message: AppLocalizations.of(context).comingSoon,
                      duration: new Duration(seconds: 5),
                    ).show(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AddComplaintViewModel(),
    );
  }
}
