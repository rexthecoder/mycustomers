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
        builder: (context, model, child) {
          model.init(customer);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(140.0),
              child: AppBar(
                brightness: Brightness.dark,
                elevation: 0.0,
                title: Container(
                  margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(15), top: 6),
                  child: Row(
                    children: <Widget>[
                    CustomerCircleAvatar(
                    customer: model.currentCustomer,
                    ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                model.currentCustomer.name ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                    color: Colors.white,
                                    fontSize: SizeConfig.yMargin(
                                        context, 2.4),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: Text(
                                model.currentCustomer.phone ?? '',
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
                                borderRadius: BorderRadius.circular(5)
                            ),
                            onPressed: (){},
                            child: Center(child: Text('View Transactions',
                              style: TextStyle(color: BrandColors.primary, fontWeight: FontWeight.bold),)),
                          ),

                        ),
                      ),

                    )),
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child:Container(child:Center(child:Text('Under Construction')),),
                  ),
                  Container(
//                    ListView.builder(builder: (BuildContext context, int index)=>Container()),
                  )

                ],
              ),
            ),
            bottomNavigationBar:
            Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: model.messageController,
                      decoration: InputDecoration(
//                        hintText: AppLocalizations

                      ),
                    ),
                  ),
                  IconButton(
                    color: BrandColors.primary,
                    onPressed: (){},
                    icon: Icon(Icons.send),
                  )
                ],
              ),
            ), height: 50,),
        );},
        viewModelBuilder: () => MessageHistoryViewModel());
  }
}
