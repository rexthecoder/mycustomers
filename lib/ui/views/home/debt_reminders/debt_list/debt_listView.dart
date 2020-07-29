import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'debt_listViewModel.dart';

class DebtList extends StatelessWidget {
  String action;
  DebtList({this.action});
  @override
  Widget build(BuildContext context) {
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<DebtListViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
              body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: SizeConfig.yMargin(context, 10),
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.yMargin(context, 5),
                    horizontal: SizeConfig.xMargin(context, 5),
                  ),
                  decoration: BoxDecoration(color: BrandColors.primary),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Total money owed: ',
                            style: TextStyle(
                              fontSize: SizeConfig.textSize(context, 5),
                              color: ThemeColors.background,
                            )),
                        Text(
                          model.transaction.currency.symbol +
                              currency
                                  .format(model.transaction.getamount(
                                      (model.transaction.bought()).toDouble()))
                                  .toString(),
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: SizeConfig.yMargin(context, 3),
                                color: Color(0xFFEB5757),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: model.transaction.formattedate.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              for (var item in model.transaction.transactions)
                                Column(
                                  children: <Widget>[
                                    item.boughtdate != null &&
                                            item.paiddate != null
                                        ? model.transaction.getDate(
                                                        item.boughtdate) ==
                                                    model.transaction
                                                        .formattedate[index] &&
                                                model.transaction.getDate(
                                                        item.paiddate) ==
                                                    model.transaction
                                                        .formattedate[index]
                                            ? Container(
                                                width: SizeConfig.xMargin(
                                                    context, 100),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xFFC4C4C4))),
                                                  color: BrandColors.primary
                                                      .withOpacity(0.03),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      //color: Colors.red,
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      width: SizeConfig.xMargin(
                                                              context, 100) *
                                                          0.48,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      2.2),
                                                              horizontal: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            model.transaction
                                                                    .getdDate(item
                                                                        .boughtdate) +
                                                                ' - ' +
                                                                model
                                                                    .transaction
                                                                    .getTime(item
                                                                        .boughtdate),
                                                            style: TextStyle(
                                                                fontSize: SizeConfig
                                                                    .yMargin(
                                                                        context,
                                                                        2),
                                                                color: Color(
                                                                    0xFF828282)),
                                                          ),
                                                          Text(
                                                            item.description ??
                                                                '',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      2.2),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig.xMargin(
                                                              context, 100) *
                                                          0.26,
                                                      child: Center(
                                                        child: Text(
                                                          model
                                                                  .transaction
                                                                  .currency
                                                                  .symbol +
                                                              currency
                                                                  .format(model
                                                                      .transaction
                                                                      .getamount(
                                                                          item.amount))
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFC80515),
                                                              fontSize: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      2.2),
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig.xMargin(
                                                              context, 100) *
                                                          0.26,
                                                      child: Center(
                                                        child: Text(
                                                          model
                                                                  .transaction
                                                                  .currency
                                                                  .symbol +
                                                              currency
                                                                  .format(model
                                                                      .transaction
                                                                      .getamount(
                                                                          item.paid))
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: BrandColors
                                                                  .primary,
                                                              fontSize: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      2.2),
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox()
                                        : item.boughtdate != null
                                            ? model.transaction.getDate(
                                                        item.boughtdate) ==
                                                    model.transaction
                                                        .formattedate[index]
                                                ? Container(
                                                    width: SizeConfig.xMargin(
                                                        context, 100),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Color(
                                                                  0xFFC4C4C4))),
                                                      color: BrandColors.primary
                                                          .withOpacity(0.03),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        Container(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: SizeConfig
                                                                      .yMargin(
                                                                          context,
                                                                          2.2),
                                                                  horizontal:
                                                                      10),
                                                          width: SizeConfig
                                                                  .xMargin(
                                                                      context,
                                                                      100) *
                                                              0.48,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                model.transaction
                                                                        .getdDate(item
                                                                            .boughtdate) +
                                                                    ' - ' +
                                                                    model
                                                                        .transaction
                                                                        .getTime(
                                                                            item.boughtdate),
                                                                style: TextStyle(
                                                                    fontSize: SizeConfig
                                                                        .yMargin(
                                                                            context,
                                                                            2),
                                                                    color: Color(
                                                                        0xFF828282)),
                                                              ),
                                                              Text(
                                                                item.description ??
                                                                    '',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: SizeConfig
                                                                      .yMargin(
                                                                          context,
                                                                          2.2),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: SizeConfig
                                                                  .xMargin(
                                                                      context,
                                                                      100) *
                                                              0.26,
                                                          child: Center(
                                                            child: Text(
                                                              model
                                                                      .transaction
                                                                      .currency
                                                                      .symbol +
                                                                  currency
                                                                      .format(model
                                                                          .transaction
                                                                          .getamount(
                                                                              item.amount))
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFFC80515),
                                                                  fontSize: SizeConfig
                                                                      .yMargin(
                                                                          context,
                                                                          2.2),
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                          ),
                                                        ),
                                                        //       Container(
                                                        //         width: SizeConfig
                                                        //                 .xMargin(
                                                        //                     context,
                                                        //                     100) *
                                                        //             0.26,
                                                        //         child: Center(
                                                        //           child: Checkbox(
                                                        //   checkColor:
                                                        //       BrandColors.primary,
                                                        //   activeColor:
                                                        //       Color(0xffE1E1E1),
                                                        //  value: model.isSelected,
                                                        //   onChanged: (value) {

                                                        //   }),
                                                        //         ),
                                                        //       )
                                                      ],
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
                InkWell(
                  onTap: () {
                    action == AppLocalizations.of(context).schedule
                        ? model.reminders.navigateToSchedule()
                        : model.reminders.navigateToSendMessage();
                  },
                  child: Container(
                    height: SizeConfig.yMargin(context, 8),
                    width: SizeConfig.xMargin(context, 80),
                    decoration: BoxDecoration(
                      color: BrandColors.primary,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.yMargin(context, 2)),
                    ),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).done,
                            style: TextStyle(color: ThemeColors.background),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 3),
                )
              ],
            ),
          ));
        },
        viewModelBuilder: () => DebtListViewModel());
  }
}
