import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'help_and_support_page_viewmodel.dart';

class HelpAndSupportPageView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController k = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
    return ViewModelBuilder<HelpAndSupportPageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: customizeAppBar(context, 1.0,
                  children: [],
                  // TODO Localize Help And Support
                  title: 'Help And Support',
                  arrowColor: BrandColors.primary,
                  backgroundColor: Theme.of(context).backgroundColor),
              body: SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      cardTile(
                        // TODO Localize Add Complaint
                        'Add Complaint',
                        model.navigateToAddComplaint,
                        context,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => HelpAndSupportPageViewModel());
  }
}

Container cardTile(
  String text,
  Function func,
  BuildContext context,
) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: SizeConfig.yMargin(context, 1),
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).cursorColor.withOpacity(0.2),
        ),
      ),
    ),
    child: ListTile(
      onTap: func,
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: SizeConfig.yMargin(context, 2),
              color: Theme.of(context).cursorColor,
            ),
      ),
      trailing: SvgPicture.asset(
        'assets/icons/arrow_right.svg',
        color: Theme.of(context).cursorColor,
      ),
    ),
  );
}

//                Padding(
//                  padding: const EdgeInsets.all(30.0),
//                  child: ListView(
//                    children: <Widget>[
//                      Form(
//                        key: _formKey,
//                        child: Column(
//                          children: <Widget>[
//                            TextFormField(
//                              textCapitalization: TextCapitalization.sentences,
//                              validator: (value) => model.validateFields(value),
//                              keyboardType: TextInputType.text,
//                              onChanged: (value) {},
//                              decoration: InputDecoration(
//                                hintText: AppLocalizations.of(context).name,
//                                hintStyle: TextStyle(fontSize: 16.sp),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(16.h, 20, 0, 16.h),
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(5.0),
//                                  borderSide: BorderSide(
//                                    color: Color(0xffd1d1d1),
//                                    width: 2,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 15.h),
//                            TextFormField(
//                              validator: (value) => model.validateFields(value),
//                              decoration: InputDecoration(
//                                hintText: AppLocalizations.of(context).email,
//                                hintStyle: TextStyle(fontSize: 16.sp),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(16.h, 20, 0, 16.h),
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(5.0),
//                                  borderSide: BorderSide(
//                                    color: Color(0xffd1d1d1),
//                                    width: 2,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 20.h),
//                            DropdownButtonFormField(
//                              hint: Text('Select a Subject'),
//                              decoration: new InputDecoration(
//                                border: const OutlineInputBorder(
//                                  borderSide: const BorderSide(
//                                    color: Color(0xFFFF8C5F),
//                                    width: 2.0,
//                                  ),
//                                ),
//                              ),
//                              value: model.items[0],
//                              items: model.items.map((String item) {
//                                return DropdownMenuItem<String>(
//                                  value: item,
//                                  child: Text(item),
//                                );
//                              }).toList(),
//                              validator: (val) {
//                                if (val == null) {
//                                  return 'Subject is required';
//                                }
//                                return null;
//                              },
//                              onChanged: (val) {},
//                            ),
//                            SizedBox(height: 19.h),
//                            TextFormField(
//                              textCapitalization: TextCapitalization.sentences,
//                              validator: (value) => model.validateFields(value),
//                              minLines: 8,
//                              maxLines: 12,
//                              decoration: InputDecoration(
//                                hintText: AppLocalizations.of(context)
//                                    .writeMessageHere,
//                                hintStyle: TextStyle(fontSize: 16.sp),
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(16.h, 20, 0, 16.h),
//                                border: new OutlineInputBorder(
//                                  borderRadius: new BorderRadius.circular(11.0),
//                                  borderSide: new BorderSide(
//                                    color: Color(0xffd1d1d1),
//                                    width: 2,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 31.h),
//                          ],
//                        ),
//                      ),
//                      RaisedButton(
//                        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5.0),
//                        ),
//                        onPressed: () {
//                          if (_formKey.currentState.validate()) {
//                            // TODO: Implement Send report service
//                          }
//                        },
//                        child: Text(
//                          AppLocalizations.of(context).send,
//                          style:
//                              TextStyle(color: Colors.white, fontSize: 16.sp),
//                        ),
//                        color: Color(0xff333cc1),
//                      )
//                    ],
//                  ),
//                ),
