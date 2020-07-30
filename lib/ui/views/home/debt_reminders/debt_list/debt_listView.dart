import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'debt_listViewModel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';

class DebtList extends StatelessWidget {
  String action;
  DebtList({this.action});
  @override
  Widget build(BuildContext context) {
    var currency = NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<DebtListViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
              appBar: customizeAppBar(
                context,
                1,
                title: '',
                arrowColor: Theme.of(context).textSelectionColor,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.yMargin(context, 5),
                  horizontal: SizeConfig.xMargin(context, 5),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.yMargin(context, 8),
                      decoration: BoxDecoration(
                          color: BrandColors.primary,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.yMargin(context, 2))),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: SizeConfig.xMargin(context, 7),
                            ),
                            Expanded(
                              child: Text(
                                  '${model.transaction.contact.name} owes you: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.textSize(context, 5),
                                    color: ThemeColors.background,
                                  )),
                            ),
                            // SizedBox(width: SizeConfig.xMargin(context, 4),),
                            Expanded(
                              child: Text(
                                model.transaction.currency.symbol +
                                    currency
                                        .format(model.transaction.getamount(
                                            (model.transaction.bought())
                                                .toDouble()))
                                        .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontSize: SizeConfig.yMargin(context, 3),
                                      color: Color(0xFFEB5757),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Item(s)',
                            style: TextStyle(
                              fontSize: SizeConfig.yMargin(context, 3),
                            )),
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: SizeConfig.yMargin(context, 3),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.transaction.formattedate.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  for (var item
                                      in model.transaction.transactions)
                                    Column(
                                      children: <Widget>[
                                        item.boughtdate != null &&
                                                item.paiddate != null
                                            ? model.transaction.getDate(
                                                            item.boughtdate) ==
                                                        model.transaction
                                                                .formattedate[
                                                            index] &&
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
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          width: SizeConfig
                                                                  .xMargin(
                                                                      context,
                                                                      100) *
                                                              0.48,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: SizeConfig
                                                                .yMargin(
                                                                    context,
                                                                    2.2),
                                                          ),
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
                                                          height: SizeConfig
                                                              .yMargin(
                                                                  context, 6),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .cursorColor),
                                                            ),
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
                                                        width:
                                                            SizeConfig.xMargin(
                                                                context, 100),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Color(
                                                                      0xFFC4C4C4))),
                                                        ),
                                                        child: Row(
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
                                                              ),
                                                              width: SizeConfig
                                                                      .xMargin(
                                                                          context,
                                                                          100) *
                                                                  0.48,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    model.transaction.getdDate(item
                                                                            .boughtdate) +
                                                                        ' - ' +
                                                                        model
                                                                            .transaction
                                                                            .getTime(item.boughtdate),
                                                                    style: TextStyle(
                                                                        fontSize: SizeConfig.yMargin(
                                                                            context,
                                                                            2),
                                                                        color: Color(
                                                                            0xFF828282)),
                                                                  ),
                                                                  SizedBox(
                                                                      height: SizeConfig.yMargin(
                                                                          context,
                                                                          1.5)),
                                                                  Text(
                                                                    item.description ??
                                                                        '',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: SizeConfig.yMargin(
                                                                          context,
                                                                          2.2),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      6),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  right: BorderSide(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .cursorColor),
                                                                ),
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
                                                                              .getamount(item.amount))
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
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
                        height: SizeConfig.yMargin(context, 7),
                        width: SizeConfig.xMargin(context, 80),
                        decoration: BoxDecoration(
                          color: BrandColors.primary,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.yMargin(context, 2)),
                        ),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).nextButton,
                                style: TextStyle(
                                    color: ThemeColors.background,
                                    fontSize: SizeConfig.textSize(context, 4)),
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
