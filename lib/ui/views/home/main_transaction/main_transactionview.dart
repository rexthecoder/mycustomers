import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class MainTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<MainTransactionViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,
                elevation: .5,
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(50)),
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/man.png',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Seyi Onifade',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: Text(
                                '08035678290',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: ScreenUtil().setSp(14),
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
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(18),
                        vertical: ScreenUtil().setHeight(10)),
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg',
                      color: Colors.black,
                    ),
                  ),
                ),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (String item) {
                      itemAction(item, context);
                    },
                    itemBuilder: (BuildContext context) {
                      return model.items.map((String item) {
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    },
                  )
                ],
                actionsIconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
              ),
              body: Column(
                children: <Widget>[
                  model.formattedate !=null?Container(): Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(20)),
                    width: width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(5)),
                                  child: SvgPicture.asset(
                                    'assets/icons/book.svg',
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Download',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          fontSize: ScreenUtil().setSp(16),
                                          color: Color(0xFF333CC1),
                                        ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Report',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          fontSize: ScreenUtil().setSp(16),
                                          color: Color(0xFF333CC1),
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(5),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/message.svg'),
                                ),
                                Container(
                                  child: Text(
                                    'Send',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize: ScreenUtil().setSp(16),
                                            color: Color(0xFF333CC1)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Reminder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize: ScreenUtil().setSp(16),
                                            color: Color(0xFF333CC1)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  model.formattedate !=null?Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/safe.png',),
                                  SizedBox(height: 20.h,),
                                  Text('MyCustomer is 100% safe and secure, only you and Seyi Onifade can view this transaction',
                                  textAlign: TextAlign.center,),
                                ],
                              ))),
                    ),
                  ): Expanded(
                    child: ListView.builder(
                        itemCount: model.formattedate.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: StickyHeader(
                              header: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(10),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(8),
                                ),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Text(
                                    model.formattedate[index].toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                  ),
                                ),
                              ),
                              content: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(25),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    for (var item in model.purchases)
                                      model.getDate(item['date']) ==
                                              model.formattedate[index]
                                          ? item['status'] == 'bought'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(15),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: ScreenUtil()
                                                              .setHeight(5),
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 8),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            15),
                                                                horizontal:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            10),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xFFE8E8E8),
                                                                      width:
                                                                          1.5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .white),
                                                              child: Text(
                                                                'NGN' +
                                                                    currency
                                                                        .format(
                                                                            item['amount'])
                                                                        .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5
                                                                    .copyWith(
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(20),
                                                                      color: Color(
                                                                          0xFF333CC1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                    ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Flexible(
                                                                child: Text(
                                                                  'Cost of goods purchased',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5
                                                                      .copyWith(
                                                                        fontSize:
                                                                            ScreenUtil().setSp(16),
                                                                        color: Colors
                                                                            .black38,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          model.getTime(
                                                              item['date']),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(15),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: ScreenUtil()
                                                              .setHeight(5),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Flexible(
                                                                child: Text(
                                                                  'Customer paid',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5
                                                                      .copyWith(
                                                                        fontSize:
                                                                            ScreenUtil().setSp(16),
                                                                        color: Colors
                                                                            .black38,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 8),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            15),
                                                                horizontal:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            10),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFFE8E8E8),
                                                                        width:
                                                                            1.5,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: Colors
                                                                          .white),
                                                              child: Text(
                                                                'NGN' +
                                                                    currency
                                                                        .format(
                                                                            item['amount'])
                                                                        .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5
                                                                    .copyWith(
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(20),
                                                                      color: Color(
                                                                          0xFF21D184),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          model.getTime(
                                                              item['date']),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                          : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(25),
                      vertical: ScreenUtil().setHeight(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        model.formattedate !=null?Container(): Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15),
                              vertical: ScreenUtil().setHeight(10),
                            ),
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(15),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            width: width,
                            child: model.bought() > model.paid()
                                ? Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Customer Owes you ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                                color: Colors.black38,
                                              ),
                                        ),
                                        Text(
                                          'NGN' +
                                              currency
                                                  .format(model.bought() -
                                                      model.paid())
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                                color: Color(0xFFEB5757),
                                                fontWeight: FontWeight.w900,
                                              ),
                                        )
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'You owe this customer ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                                color: Colors.black38,
                                              ),
                                        ),
                                        Text(
                                          'NGN' +
                                              currency
                                                  .format(model.paid() -
                                                      model.bought())
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                                color: Color(0xFFEB5757),
                                                fontWeight: FontWeight.w900,
                                              ),
                                        )
                                      ],
                                    ),
                                  )),
                        AddTransaction(width),
//                        InkWell(
//                          onTap: () {
//
//                            showBottomSheet(context: context,
//                            builder: (context)=> Container());
//                          },
//                          child: Container(
//                            padding: EdgeInsets.symmetric(
//                              vertical: ScreenUtil().setHeight(15),
//                            ),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(5.0),
//                              color: Color(0xFF333CC1),
//                            ),
//                            width: width,
//                            child: Center(
//                              child: Text(
//                                'Add Transaction',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .headline6
//                                    .copyWith(
//                                      fontSize: ScreenUtil().setSp(16),
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold,
//                                    ),
//                              ),
//                            ),
//                          ),
//                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
        viewModelBuilder: () => MainTransactionViewModel());
  }

  void itemAction(String item, BuildContext context) {
    if (item == 'SMS') {
      Navigator.pushNamed(context, '/transactionHistory');
      //Code to send sms
    } else if (item == 'Call') {
      Navigator.pushNamed(context, '/transactionDetails');
      //Code to call customer
    } else {
      //Code to Set Reminder
    }
  }
}



class AddTransaction extends StatelessWidget {
  final double width;
  AddTransaction(this.width);
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {

        showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.5),
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200.h,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/addDebt');
                      },
                        child: Container(
                          height: 50.h,
                            child: Center(child: Text('Add Debt',style: TextStyle(
                              color: BrandColors.secondary
                            ),)))),
                    Divider(color: Colors.black),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/addCredit');
                        },
                        child: Container(
                            height: 50.h,
                            child: Center(child: Text('Add Credit',style: TextStyle(
                                color: BrandColors.primary
                            ),)))),
                    Divider(color: Colors.black),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 50.h,
                            child: Center(child: Text('Cancel',style: TextStyle(
                                color: Colors.red
                            ),)))),
                  ],
                ),
              ),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(15),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color(0xFF333CC1),
        ),
        width: width,
        child: Center(
          child: Text(
            'Add Transaction',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(
              fontSize: ScreenUtil().setSp(16),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
