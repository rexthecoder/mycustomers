import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';

import 'debt_list_viewmodel.dart';

class DebtList extends StatelessWidget {
  final String action;
  DebtList({this.action});
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).backgroundColor
        : ThemeColors.gray.shade600;
    var currency = NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<DebtListViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
              appBar: customizeAppBar(
                context,
                1,
                title: 'Debt List',
                arrowColor: action == 'send' ? BrandColors.secondary : Theme.of(context).textSelectionColor,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              body: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.yMargin(context, 3),
                  left: SizeConfig.xMargin(context, 7),
                  right: SizeConfig.xMargin(context, 7),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      //padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      // height: 30,
                      //color: backgroundColor,
                      //alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                'Total Amount ${model.contact.name} owes you is:  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        SizeConfig.textSize(context, 3.5))),
                          ),
//                          SizedBox(width: SizeConfig.xMargin(context, 0.2)),
                          Text(
                            model.currency.symbol +
                                currency
                                    .format(model.getamount(
                                        (model.bought())
                                            .toDouble()))
                                    .toString(),
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: SizeConfig.yMargin(context, 3),
                                      color: Color(0xFFEB5757),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 4),
                    ),
                    Container(
                      width: double.infinity,
                      height: 30,
                      child: Text(
                        "Kindly click on a debt from the list to send a single reminder.",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: SizeConfig.yMargin(context, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Item(s)',
                            style: TextStyle(
                              fontSize: SizeConfig.yMargin(context, 2),
                            )),
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: SizeConfig.yMargin(context, 2),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.formattedate.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  for (var item
                                      in model.transactions)
                                    Column(
                                      children: <Widget>[
                                        item.boughtdate != null &&
                                                item.paiddate != null
                                            ? model.getDate(
                                                            item.boughtdate) ==
                                                        model.formattedate[
                                                            index] &&
                                                    model.getDate(
                                                            item.paiddate) ==
                                                        model.formattedate[index]
                                                ? InkWell(
                                                    onTap: () {
                                                      action == 'schedule'
                                                          ? model
                                                              .navigateToScheduleSingleDebt(
                                                                  item)
                                                          : model
                                                              .navigateToSendSingleDebt(
                                                                  item);
                                                    },
                                                    child: Container(
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
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  model.getdDate(item
                                                                              .boughtdate) +
                                                                      ' - ' +
                                                                      model
                                                                          .getTime(
                                                                              item.boughtdate),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          SizeConfig.yMargin(
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Center(
                                                              child: Text(
                                                                model
                                                                        .currency
                                                                        .symbol +
                                                                    currency
                                                                        .format(model
                                                                            .getamount(item.paid))
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
                                                    ),
                                                  )
                                                : SizedBox()
                                            : item.boughtdate != null
                                                ? model.getDate(
                                                            item.boughtdate) ==
                                                        model.formattedate[index]
                                                    ? InkWell(
                                                        onTap: () {
                                                          action == 'schedule'
                                                              ? model
                                                                  .navigateToScheduleSingleDebt(
                                                                      item)
                                                              : model
                                                                  .navigateToSendSingleDebt(
                                                                      item);
                                                        },
                                                        child: Container(
                                                          width: SizeConfig
                                                              .xMargin(
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
                                                                      model.getdDate(item
                                                                              .boughtdate) +
                                                                          ' - ' +
                                                                          model
                                                                              .getTime(item.boughtdate),
                                                                      style: TextStyle(
                                                                          fontSize: SizeConfig.yMargin(
                                                                              context,
                                                                              2),
                                                                          color:
                                                                              Color(0xFF828282)),
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
                                                                            FontWeight.bold,
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
                                                                  border:
                                                                      Border(
                                                                    right: BorderSide(
                                                                        color: Theme.of(context)
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
                                                                            .currency
                                                                            .symbol +
                                                                        currency
                                                                            .format(model.getamount(item.amount))
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
                    Text(
                        action == 'send'
                            ? 'Or Click the button below to send a reminder of the total debt Amount ${model.contact.name} owes you'
                            : 'Or Click the button below to schedule reminder of the debt total ${model.contact.name} owes you',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 1),
                    ),
                    Container(
                      width: SizeConfig.xMargin(context, 70),
                      child: CustomRaisedButton(
                        child: Container(),
                        btnColor: action == 'send' ? BrandColors.secondary : BrandColors.primary,
                        txtColor: ThemeColors.background,
                        borderColor: action == 'send' ? BrandColors.secondary : BrandColors.primary,
                        btnText: action == 'send'
                            ? "Send reminder for total amount"
                            : "Schedule reminder for total amount",
                        onPressed: () {
                          action == 'schedule'
                              ? model.navigateToSchedule()
                              : model.navigateToSendMessage();
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 2),
                    )
                  ],
                ),
              ));
        },
        viewModelBuilder: () => DebtListViewModel());
  }
}
