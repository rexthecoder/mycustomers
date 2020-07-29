import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_viewmodel.dart';
import 'package:mycustomers/core/models/customer.dart';

class QuickMessageView extends StatelessWidget {
  final List<Customer> selectedCustomers = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      height: height,
      width: width,
    );
    return ViewModelBuilder<QuickMessageViewModel>.reactive(
      viewModelBuilder: () => QuickMessageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendMessage,
              arrowColor: BrandColors.primary,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: quickMessageTitle.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.h,
                      ),
                      FlatButton(
                        onPressed: () => model.navigateToMessageView(
                            //selectedCustomers,
                            quickMessageTitle[index],
                            quickMessageText[index]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: BrandColors.secondary.withOpacity(0.5))),
                        child: Container(
                          height: 100.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        quickMessageTitle[index],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        quickMessageText[index],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context).seeAll,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: BrandColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                FlatButton(
                  color: BrandColors.primary,
                  onPressed: () {
                    model.navigateToMessage(
                      //selectedCustomers,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 50.h,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).composeMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
