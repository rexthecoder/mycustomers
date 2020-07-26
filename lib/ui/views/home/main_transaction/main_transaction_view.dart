import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/pdf/receipt_report_view.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class MainTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<MainTransactionViewModel>.reactive(
        onModelReady: (model) {
          model.getTransactions();
        },
        builder: (context, model, child) => WillPopScope(
              onWillPop: () async {
                model.navigateToHome();
                return true;
              },
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70.0),
                  child: AppBar(
                    brightness: Brightness.dark,
                    elevation: 0.0,
                    title: Container(
                      margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(15), top: 6),
                      child: Row(
                        children: <Widget>[
                          model.contact.initials != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: ThemeColors.background,
                                    child: Text(
                                      model.contact.initials,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionColor),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    model.contact.name ?? '',
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
                                    model.contact.phoneNumber ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.yMargin(context, 2),
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
                      onTap: () => model.navigateToHome(),
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
                    // actions: <Widget>[
                    //   PopupMenuButton<String>(
                    //     onSelected: (String item) {
                    //       itemAction(item, context);
                    //     },
                    //     itemBuilder: (BuildContext context) {
                    //       return model.items.map((String item) {
                    //         return PopupMenuItem<String>(
                    //           value: item,
                    //           child: Text(
                    //             item,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .headline6
                    //                 .copyWith(
                    //                     fontSize:
                    //                         SizeConfig.yMargin(context, 2)),
                    //           ),
                    //         );
                    //       }).toList();
                    //     },
                    //   )
                    // ],
                    actionsIconTheme:
                        IconThemeData(color: Theme.of(context).cursorColor),
                    backgroundColor: BrandColors.primary,
                    centerTitle: true,
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    model.formattedate.length == 0
                        ? SizedBox()
                        : Container(
                            color: BrandColors.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(25),
                              vertical: SizeConfig.yMargin(context, 2.2),
                            ),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.xMargin(context, 1.5),
                                  vertical: ScreenUtil().setHeight(13),
                                ),
                                // margin: EdgeInsets.only(
                                //   bottom: ScreenUtil().setHeight(5),
                                // ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context).backgroundColor),
                                width: width,
                                child: model.bought() > model.paid()
                                    ? Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(//${model.contact.name}
                                              'This customer' +
                                                  ' ' +
                                                  AppLocalizations.of(context)
                                                      .owesYou +
                                                  ' ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .cursorColor,
                                                  ),
                                            ),
                                            SizedBox(
                                                width: SizeConfig.xMargin(
                                                    context, 14)),
                                            Text(
                                              model.currency.symbol +
                                                  currency
                                                      .format(model.getamount(
                                                          (model.bought() -
                                                                  model.paid())
                                                              .toDouble()))
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.8),
                                                    color: Color(0xFFEB5757),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                      .youOwe +
                                                  ' this customer ',//${model.contact.name}
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.2),
                                                    color: Theme.of(context)
                                                        .cursorColor,
                                                  ),
                                            ),
                                            SizedBox(
                                                width: SizeConfig.xMargin(
                                                    context, 14)),
                                            Text(
                                              model.currency.symbol +
                                                  currency
                                                      .format(model.getamount(
                                                          (model.paid() -
                                                                  model
                                                                      .bought())
                                                              .toDouble()))
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2.8),
                                                    color: Color(0xFFEB5757),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            )
                                          ],
                                        ),
                                      )),
                          ),
                    model.formattedate.length == 0
                        ? SizedBox()
                        : Card(
                            margin: EdgeInsets.zero,
                            elevation: 1.5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(15)),
                              width: width,
                              color: Theme.of(context).backgroundColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      flusher('Still in development', context);
                                      // SavedDialog().showPdfDialog(context);

                                      // // ReceiptReport().buildPdf(context);
                                      // // await ReceiptReport()
                                      // //     .generateReport(context);
                                    },
                                    child: Container(
                                      width: SizeConfig.xMargin(context, 100) *
                                          0.3,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(5)),
                                            child: SvgPicture.asset(
                                              'assets/images/pdf.svg',
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .report,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 2.2),
                                                      color: Theme.of(context)
                                                          .textSelectionColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {}, //Todo: Call Functionality
                                    child: Container(
                                      width: SizeConfig.xMargin(context, 100) *
                                          0.3,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: ScreenUtil().setHeight(5),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/phone_device.svg',
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              AppLocalizations.of(context).call,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 2.2),
                                                      color: Theme.of(context)
                                                          .textSelectionColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      model.navigateToSchedule();
                                    },
                                    child: Container(
                                      width: SizeConfig.xMargin(context, 100) *
                                          0.3,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: ScreenUtil().setHeight(5),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/message.svg',
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .reminder,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 2.2),
                                                      color: Theme.of(context)
                                                          .textSelectionColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    model.formattedate.length == 0
                        ? SizedBox()
                        : Container(
                            width: SizeConfig.xMargin(context, 100),
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.yMargin(context, 2.2)),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xFFC4C4C4))),
                              color: BrandColors.primary.withOpacity(0.03),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                //SizedBox(width: SizeConfig.xMargin(context, 15)),
                                Container(
                                  //color: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.xMargin(context, 5)),
                                  width:
                                      SizeConfig.xMargin(context, 100) * 0.48,
                                  child: Text(
                                    AppLocalizations.of(context).details,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.yMargin(context, 2)),
                                  ),
                                ),
                                //SizedBox(width: SizeConfig.xMargin(context, 15)),
                                Container(
                                  //color: Colors.red,
                                   width:
                                      SizeConfig.xMargin(context, 100) * 0.26,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context).owesYou,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.yMargin(context, 2)),
                                    ),
                                  ),
                                ),
                                //SizedBox(width: SizeConfig.xMargin(context, 3)),
                                Container(
                                  //color: Colors.red,
                                  width:
                                      SizeConfig.xMargin(context, 100) * 0.26,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context).paidYou,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.yMargin(context, 2)),
                                    ),
                                  ),
                                ),
                                //SizedBox(width: SizeConfig.xMargin(context, 2)),
                              ],
                            ),
                          ),
                    model.formattedate.length == 0
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                  child: Center(
                                      child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                      'assets/images/no_transaction_check.svg'),
//                                  SizedBox(
//                                    height: 20.h,
//                                  ),
//                                  Text(
//                                      "${AppLocalizations.of(context).isSafeAndSecure} " +
//                                          " ${model.contact.name} " +
//                                          " ${AppLocalizations.of(context).canViewThisTransaction}"
//                                      // 'MyCustomer is 100% safe and secure, only you and \
//                                      // ${model.contact.name} can view this transaction',
//                                      // textAlign: TextAlign.center,
//                                      ),
                                ],
                              ))),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: model.formattedate.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        for (var item in model.transactions)
                                          Column(
                                            children: <Widget>[
                                              item.boughtdate != null &&
                                                      item.paiddate != null
                                                  ? model.getDate(item.boughtdate) ==
                                                              model.formattedate[
                                                                  index] &&
                                                          model.getDate(item
                                                                  .paiddate) ==
                                                              model.formattedate[
                                                                  index]
                                                      ? InkWell(
                                                          onTap: () {
                                                            //model.navigateDetails(item);
                                                          },
                                                          child: Container(
                                                            // margin: EdgeInsets.symmetric(
                                                            //     horizontal:
                                                            //         SizeConfig
                                                            //             .xMargin(
                                                            //                 context,
                                                            //                 4)),
                                                            width: SizeConfig
                                                                .xMargin(
                                                                    context,
                                                                    100),
                                                            //padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2.2)),
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Color(
                                                                          0xFFC4C4C4))),
                                                              color: BrandColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.03),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  //color: Colors.red,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .backgroundColor,
                                                                  width: SizeConfig.xMargin(
                                                                          context,
                                                                          100) *
                                                                      0.48,
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: SizeConfig.yMargin(
                                                                          context,
                                                                          2.2),
                                                                      horizontal:
                                                                          10),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        model.getdDate(item.boughtdate) +
                                                                            ' - ' +
                                                                            model.getTime(item.boughtdate),
                                                                        style: TextStyle(
                                                                            fontSize: SizeConfig.yMargin(context,
                                                                                2),
                                                                            color:
                                                                                Color(0xFF828282)),
                                                                      ),
                                                                      Text(
                                                                        item.description ??
                                                                            '',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize: SizeConfig.yMargin(
                                                                              context,
                                                                              2.2),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Expanded(
                                                                //   child:
                                                                Container(
                                                                  //color: Colors.red,
                                                                  //color: BrandColors.primary.withOpacity(0.03),
                                                                  width: SizeConfig.xMargin(
                                                                          context,
                                                                          100) *
                                                                      0.26,
                                                                  child: Center(
                                                                    child: Text(
                                                                      model.currency
                                                                              .symbol +
                                                                          currency
                                                                              .format(model.getamount(item.amount))
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Color(
                                                                              0xFFC80515),
                                                                          fontSize: SizeConfig.yMargin(
                                                                              context,
                                                                              2.2),
                                                                          fontFamily:
                                                                              'Roboto'),
                                                                    ),
                                                                  ),
                                                                ),
                                                                //),
                                                                // Expanded(
                                                                //   child:
                                                                Container(
                                                                  //color: Colors.red,
                                                                  width: SizeConfig.xMargin(
                                                                          context,
                                                                          100) *
                                                                      0.26,
                                                                  child: Center(
                                                                    child: Text(
                                                                      model.currency
                                                                              .symbol +
                                                                          currency
                                                                              .format(model.getamount(item.paid))
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: BrandColors
                                                                              .primary,
                                                                          fontSize: SizeConfig.yMargin(
                                                                              context,
                                                                              2.2),
                                                                          fontFamily:
                                                                              'Roboto'),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox()
                                                  : item.boughtdate != null
                                                      ? model.getDate(item
                                                                  .boughtdate) ==
                                                              model.formattedate[
                                                                  index]
                                                          ? InkWell(
                                                              onTap: () {
                                                                //model.navigateDetails(item);
                                                              },
                                                              child: Container(
                                                                width: SizeConfig
                                                                    .xMargin(
                                                                        context,
                                                                        100),
                                                                //padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2.2)),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Color(0xFFC4C4C4))),
                                                                  color: BrandColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.03),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      //color: Colors.red,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .backgroundColor,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: SizeConfig.yMargin(
                                                                              context,
                                                                              2.2),
                                                                          horizontal:
                                                                              10),
                                                                      width: SizeConfig.xMargin(
                                                                              context,
                                                                              100) *
                                                                          0.48,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            model.getdDate(item.boughtdate) +
                                                                                ' - ' +
                                                                                model.getTime(item.boughtdate),
                                                                            style:
                                                                                TextStyle(fontSize: SizeConfig.yMargin(context, 2), color: Color(0xFF828282)),
                                                                          ),
                                                                          Text(
                                                                            item.description ??
                                                                                '',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: SizeConfig.yMargin(context, 2.2),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //color: Colors.red,
                                                                      //color: BrandColors.primary.withOpacity(0.03),
                                                                      width: SizeConfig.xMargin(
                                                                              context,
                                                                              100) *
                                                                          0.26,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          model.currency.symbol +
                                                                              currency.format(model.getamount(item.amount)).toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color(0xFFC80515),
                                                                              fontSize: SizeConfig.yMargin(context, 2.2),
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //color: Colors.red,
                                                                      width: SizeConfig.xMargin(
                                                                              context,
                                                                              100) *
                                                                          0.26,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            ''),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                      : item.paiddate != null
                                                          ? model.getDate(item
                                                                      .paiddate) ==
                                                                  model
                                                                      .formattedate[index]
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    //model.navigateDetails(item);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    //color: BrandColors.primary.withOpacity(0.03),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border(
                                                                          bottom:
                                                                              BorderSide(color: Color(0xFFC4C4C4))),
                                                                      color: BrandColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.03),
                                                                    ),
                                                                    width: SizeConfig
                                                                        .xMargin(
                                                                            context,
                                                                            100),
                                                                    //padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2.2)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          color:
                                                                              Theme.of(context).backgroundColor,
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: SizeConfig.yMargin(context, 2.2),
                                                                              horizontal: 10),
                                                                          width:
                                                                              SizeConfig.xMargin(context, 100) * 0.48,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                model.getdDate(item.paiddate) + ' - ' + model.getTime(item.paiddate),
                                                                                style: TextStyle(fontSize: SizeConfig.yMargin(context, 2), color: Color(0xFF828282)),
                                                                              ),
                                                                              Text(
                                                                                item.description ?? '',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: SizeConfig.yMargin(context, 2.2),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          //color: Colors.red,
                                                                          //color: BrandColors.primary.withOpacity(0.03),
                                                                          width:
                                                                              SizeConfig.xMargin(context, 100) * 0.26,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(''),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          //color: Colors.red,
                                                                          width:
                                                                              SizeConfig.xMargin(context, 100) * 0.26,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              model.currency.symbol + currency.format(model.getamount(item.paid)).toString(),
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: BrandColors.primary, fontSize: SizeConfig.yMargin(context, 2.2), fontFamily: 'Roboto'),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox()
                                                          : SizedBox(),
                                            ],
                                          )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                    Container(
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: ScreenUtil().setWidth(25),
                      //   vertical: ScreenUtil().setHeight(12),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // model.formattedate.length == 0
                          //     ? SizedBox()
                          //     : Container(
                          //         padding: EdgeInsets.symmetric(
                          //           horizontal: ScreenUtil().setWidth(25),
                          //           vertical: SizeConfig.yMargin(context, 2),
                          //         ),
                          //         child: Container(
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal:
                          //                   SizeConfig.xMargin(context, 3),
                          //               vertical: ScreenUtil().setHeight(10),
                          //             ),
                          //             // margin: EdgeInsets.only(
                          //             //   bottom: ScreenUtil().setHeight(5),
                          //             // ),
                          //             decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(50),
                          //                 color: Theme.of(context)
                          //                     .backgroundColor),
                          //             width: width,
                          //             child: model.bought() > model.paid()
                          //                 ? Center(
                          //                     child: Wrap(
                          //                       alignment: WrapAlignment.center,
                          //                       children: <Widget>[
                          //                         Text(
                          //                           '${model.contact.name} ' + AppLocalizations.of(context).owesYou  + ' ',
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.3),
                          //                                 color:
                          //                                     Theme.of(context)
                          //                                         .cursorColor,
                          //                               ),
                          //                         ),
                          //                         Text(
                          //                           model.currency.symbol +
                          //                               currency
                          //                                   .format(model
                          //                                           .bought() -
                          //                                       model.paid())
                          //                                   .toString(),
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.5),
                          //                                 color:
                          //                                     Color(0xFFEB5757),
                          //                                 fontFamily: 'Roboto',
                          //                                 fontWeight:
                          //                                     FontWeight.w900,
                          //                               ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )
                          //                 : Center(
                          //                     child: Wrap(
                          //                       alignment: WrapAlignment.center,
                          //                       children: <Widget>[
                          //                         Text(
                          //                           'You owe ${model.contact.name} ',
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.3),
                          //                                 color:
                          //                                     Theme.of(context)
                          //                                         .cursorColor,
                          //                               ),
                          //                         ),
                          //                         Text(
                          //                           model.currency.symbol +
                          //                               currency
                          //                                   .format(model
                          //                                           .paid() -
                          //                                       model.bought())
                          //                                   .toString(),
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .headline5
                          //                               .copyWith(
                          //                                 fontSize: SizeConfig
                          //                                     .yMargin(
                          //                                         context, 2.5),
                          //                                 color:
                          //                                     Color(0xFFEB5757),
                          //                                 fontFamily: 'Roboto',
                          //                                 fontWeight:
                          //                                     FontWeight.w900,
                          //                               ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )),
                          //       ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(25),
                                vertical: SizeConfig.yMargin(context, 2),
                              ),
                              child: AddTransaction(
                                  width, model.debitlist, model.creditlist)),
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
            ),
        viewModelBuilder: () => MainTransactionViewModel());
  }

  void itemAction(String item, BuildContext context) {
    if (item == AppLocalizations.of(context).sms) {
      // Navigator.pushNamed(context, '/transactionHistory');
      //TODO: Code to send sms
    } else if (item == AppLocalizations.of(context).call) {
      // Navigator.pushNamed(context, '/transactionDetails');
      //TODO: Code to call customer
    } else {
      //
    }
  }
}



class AddTransaction extends StatelessWidget {
  final double width;
  final List<TransactionModel> debitlist;
  final List<TransactionModel> creditlist;
  AddTransaction(this.width, this.debitlist, this.creditlist);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   showModalBottomSheet(
      //       context: context,
      //       barrierColor: Colors.black.withOpacity(0.5),
      //       builder: (context) => Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Container(
      //               height: SizeConfig.yMargin(context, 30),
      //               child: Column(
      //                 children: <Widget>[
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                         creditlist.length == 0
      //                             ? Navigator.pushNamed(context, '/addDebt')
      //                             : Navigator.pushNamed(
      //                                 context, '/selectCredit');
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Add Debt',
      //                             style: TextStyle(
      //                                 color:
      //                                     Theme.of(context).textSelectionColor,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                   Divider(color: Colors.black.withOpacity(0.5)),
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                         debitlist.length == 0
      //                             ? Navigator.pushNamed(context, '/addCredit')
      //                             : Navigator.pushNamed(context, '/selectDebt');
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Add Credit',
      //                             style: TextStyle(
      //                                 color: BrandColors.secondary,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                   Divider(color: Colors.black.withOpacity(0.5)),
      //                   InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Container(
      //                           height: SizeConfig.yMargin(context, 8),
      //                           child: Center(
      //                               child: Text(
      //                             'Cancel',
      //                             style: TextStyle(
      //                                 color: Colors.red,
      //                                 fontSize:
      //                                     SizeConfig.yMargin(context, 2.3)),
      //                           )))),
      //                 ],
      //               ),
      //             ),
      //           ));
      // },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              //creditlist.length == 0?
              Navigator.pushNamed(context, '/addDebt');
              // : Navigator.pushNamed(context, '/selectCredit');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFFEB5757),
              ),
              width: width / 2.5,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).addDebt,
                  //AppLocalizations.of(context).theyAreOwingYou,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: SizeConfig.yMargin(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //debitlist.length == 0?
              Navigator.pushNamed(context, '/addCredit');
              //: Navigator.pushNamed(context, '/selectDebt');
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(15),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).textSelectionColor,
              ),
              width: width / 2.5,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).addPayment,
                  //AppLocalizations.of(context).youAreOwingThem,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: SizeConfig.yMargin(context, 2),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
