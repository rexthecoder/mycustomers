import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/message_history/message_history_viewmodel.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:stacked/stacked.dart';

class MessageHistoryView extends StatelessWidget {
  final Customer customer;
  MessageHistoryView({this.customer});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<MessageHistoryViewModel>.reactive(
        onModelReady: (model) => model.getMessages(),
        builder: (context, model, child) {
          //model.init(customer);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(140.0),
              child: AppBar(
                brightness: Brightness.dark,
                elevation: 0.0,
                title: Container(
                  margin:
                      EdgeInsets.only(right: ScreenUtil().setWidth(15), top: 6),
                  child: Row(
                    children: <Widget>[
                      CustomerCircleAvatar(
                        ccustomer: model.customer,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                model.customer.name ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.yMargin(context, 2.4),
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: Text(
                                model.customer.phoneNumber ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.yMargin(context, 1.8),
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                leading: InkWell(
                  onTap: () => model.popView(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(18),
                        vertical: ScreenUtil().setHeight(10)),
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
                actionsIconTheme:
                    IconThemeData(color: Theme.of(context).cursorColor),
                backgroundColor: BrandColors.primary,
                centerTitle: true,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(70.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(10)),
                      height: 70,
                      child: Container(
//                        padding: EdgeInsets.all(2.0),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5)
//                        ),
//                        onPressed: (){},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: 50,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              model.navigateToTransaction();
                            },
                            child: Center(
                                child: Text(
                              'View Transactions',
                              style: TextStyle(
                                  color: BrandColors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            //reverse: true,
                            itemCount: model.messages.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  //color: Colors.red,
                                  child: Padding(
//                          padding: const EdgeInsets.symmetric(vertical: 20),
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 60, right: 20),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            model.messages[index].message ?? '',
                                            textAlign: TextAlign.end,
                                          ),
                                        ))),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            vertical: BorderSide(color: ThemeColors.gray[700])),
                        color: Theme.of(context).backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100.h,
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.dummyQuickText.length,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              color: BrandColors.primary
                                                  .withOpacity(0.3),
                                              onPressed: () => model.setText(
                                                  model.dummyQuickText[index]),
                                              child: Container(
                                                  height: 30,
                                                  child: Center(
                                                      child: Text(
                                                          model.dummyQuickText[
                                                              index])))),
                                        ),
                                      )),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: model.messageController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
//                        hintText: AppLocalizations
                                      ),
                                      onChanged: model.updatetext,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      model.send();
                                    },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: BrandColors.primary,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => MessageHistoryViewModel());
  }
}
