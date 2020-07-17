import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'add_debt_credit_viewmodel.dart';

class AddDebtCreditView extends StatelessWidget {
  final String action;
  final bool update;

  const AddDebtCreditView({Key key, this.action, this.update})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    NotificationRemindersService reminders = NotificationRemindersService();
    return ViewModelBuilder<AddDebtCreditViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              elevation: 1,
              title: Text(
                action == 'debit'
                    ? model.amount != null
                        ? '${model.contact.name} owes you ₦' +
                            model.amount.round().toString()
                        : '${model.contact.name} owes you'
                    : model.amount != null
                        ? '${model.contact.name} paid you ₦' +
                            model.amount.round().toString()
                        : '${model.contact.name} paid you',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.bold,
                    color: action == 'credit'
                        ? BrandColors.secondary
                        : BrandColors.primary,
                    fontFamily: 'Roboto'),
              ),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18),
                      vertical: ScreenUtil().setHeight(10)),
                  child: SvgPicture.asset(
                    'assets/icons/backarrow.svg',
                    color: action == 'credit'
                        ? BrandColors.secondary
                        : BrandColors.primary,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(15),
                  horizontal: ScreenUtil().setWidth(20)),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).transactionDetails,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize:
                                              SizeConfig.yMargin(context, 2.6),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(15)),
                              child: TextField(
                                maxLines: null,
                                maxLengthEnforced: false,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: action == 'credit'
                                            ? BrandColors.secondary
                                            : BrandColors.primary,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.bold),
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: action == 'credit'
                                            ? BrandColors.secondary
                                            : BrandColors.primary,
                                        width: 2.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: action == 'credit'
                                            ? BrandColors.secondary
                                            : BrandColors.primary,
                                        width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: action == 'credit'
                                            ? BrandColors.secondary
                                            : BrandColors.primary,
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: action == 'credit'
                                            ? BrandColors.secondary
                                            : BrandColors.primary,
                                        width: 2.0),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  hintText: action == 'credit'
                                      ? 'Enter Amount ${model.contact.name} Paid You'
                                      : 'Enter Amount ${model.contact.name} Owes You',
                                  hintStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.yMargin(context, 2.3)),
                                  errorText: model.error,
                                  prefixIcon: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(15),
                                          horizontal:
                                              ScreenUtil().setWidth(10)),
                                      child: Text(
                                        model.currency.symbol,
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontSize:
                                                SizeConfig.yMargin(context, 3),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                      )),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(8)),
                                ),
                                textInputAction: TextInputAction.go,
                                onChanged: (value) =>
                                    model.updateAmount(value, update, action),
                              ),
                            ),
                            Visibility(
                              visible: model.show,
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: model.selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: action == 'credit'
                                            ? DateTime(2030)
                                            : DateTime(
                                                int.parse(DateFormat('yyyy')
                                                    .format(DateTime.now())),
                                                int.parse(DateFormat('MM')
                                                    .format(DateTime.now())),
                                                int.parse(DateFormat('dd')
                                                    .format(DateTime.now()))),
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              primaryColor: action == 'credit'
                                                  ? BrandColors.secondary
                                                  : BrandColors.primary,
                                              accentColor: action == 'credit'
                                                  ? BrandColors.secondary
                                                  : BrandColors.primary,
                                              colorScheme: Theme.of(context)
                                                  .colorScheme
                                                  .copyWith(
                                                      primary:
                                                          action == 'credit'
                                                              ? BrandColors
                                                                  .secondary
                                                              : BrandColors
                                                                  .primary),
                                              buttonTheme: ButtonThemeData(
                                                  textTheme:
                                                      ButtonTextTheme.primary),
                                            ),
                                            child: child,
                                          );
                                        },
                                      );
                                      if (picked != null)
                                        model.setOtherDate(
                                            picked, update, action);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(15),
                                          horizontal:
                                              ScreenUtil().setWidth(15)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: model.date2err
                                                  ? Colors.red
                                                  : Color(0xFFD1D1D1),
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(5))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(15)),
                                            child: SvgPicture.asset(
                                                'assets/icons/calendar.svg',
                                                color: action == 'credit'
                                                    ? BrandColors.secondary
                                                    : BrandColors.primary),
                                          ),
                                          Container(
                                            child: Text(
                                              model.newODate != null
                                                  ? model.newODate
                                                  : action == 'debit'
                                                      ? 'Select Date of Purchase'
                                                      : 'Select Date of Payment',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    color: action == 'credit'
                                                        ? BrandColors.secondary
                                                        : BrandColors.primary,
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  action == 'credit'
                                      ? SizedBox()
                                      : InkWell(
                                          onTap: () async {
                                            final DateTime picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: model.selectedDate,
                                              firstDate: DateTime(
                                                  int.parse(DateFormat('yyyy')
                                                      .format(DateTime.now())),
                                                  int.parse(DateFormat('MM')
                                                      .format(DateTime.now())),
                                                  int.parse(DateFormat('dd')
                                                      .format(DateTime.now()))),
                                              lastDate: DateTime(2300),
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    primaryColor: action ==
                                                            'credit'
                                                        ? BrandColors.secondary
                                                        : BrandColors.primary,
                                                    accentColor: action ==
                                                            'credit'
                                                        ? BrandColors.secondary
                                                        : BrandColors.primary,
                                                    colorScheme: Theme.of(
                                                            context)
                                                        .colorScheme
                                                        .copyWith(
                                                            primary:
                                                                action ==
                                                                        'credit'
                                                                    ? BrandColors
                                                                        .secondary
                                                                    : BrandColors
                                                                        .primary),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child,
                                                );
                                              },
                                            );
                                            if (picked != null)
                                              model.setDate(picked);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().setHeight(15),
                                                horizontal:
                                                    ScreenUtil().setWidth(15)),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: model.date1err
                                                        ? Colors.red
                                                        : Color(0xFFD1D1D1),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setWidth(5))),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(15)),
                                                  child: SvgPicture.asset(
                                                      'assets/icons/calendar.svg',
                                                      color: action == 'credit'
                                                          ? BrandColors
                                                              .secondary
                                                          : BrandColors
                                                              .primary),
                                                ),
                                                Container(
                                                  child: Text(
                                                    model.newDate ??
                                                        'Select Due Date',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                          fontSize: ScreenUtil()
                                                              .setSp(16),
                                                          color:
                                                              action == 'credit'
                                                                  ? BrandColors
                                                                      .secondary
                                                                  : BrandColors
                                                                      .primary,
                                                        ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  Visibility(
                                    visible: update ? false : true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setWidth(10),
                                          vertical: ScreenUtil().setHeight(4)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFD1D1D1),
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(5))),
                                      child: Column(
                                        children: <Widget>[
                                          TextField(
                                            controller: _controller,
                                            maxLines: null,
                                            maxLengthEnforced: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: AppLocalizations.of(context).enterItemspurchased,
                                              hintStyle: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(15)),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: ScreenUtil()
                                                        .setHeight(10)),
                                                child: SvgPicture.asset(
                                                  'assets/icons/cart.svg',
                                                ),
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  _controller.clear();
                                                  model.addItem(action, update);
                                                },
                                                child: Container(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.add,
                                                        color:
                                                            action == 'credit'
                                                                ? BrandColors
                                                                    .secondary
                                                                : BrandColors
                                                                    .primary,
                                                        size: ScreenUtil()
                                                            .setWidth(18),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          'Add',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .copyWith(
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                    color: action ==
                                                                            'credit'
                                                                        ? BrandColors
                                                                            .secondary
                                                                        : BrandColors
                                                                            .primary,
                                                                  ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            textInputAction: TextInputAction.go,
                                            onSubmitted: (value) {
                                              _controller.clear();
                                              model.addItem(action, update);
                                            },
                                            onChanged: model.updateItem,
                                          ),
                                          for (var item in model.items)
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: ScreenUtil()
                                                      .setHeight(4)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: ScreenUtil()
                                                      .setHeight(10),
                                                  horizontal: ScreenUtil()
                                                      .setWidth(15)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setWidth(5)),
                                                color: Color(0xFFF0F0F0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Flexible(
                                                      child: Text(
                                                        item,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            .copyWith(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            16),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      model.removeItem(model
                                                          .items
                                                          .indexOf(item));
                                                    },
                                                    child: Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/cancel.svg'),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      model.addtransaction(action, update);
                      reminders.sendNotificationOnce(
                          0,
                          'Reminder: ',
                          action == 'credit'
                              ? 'You owe ${model.contact.name} ' +
                                  model.amount.round().toString()
                              : '${model.contact.name} owes you ' +
                                  model.amount.round().toString(),
                          action == 'debit' ? model.dueDate : model.otherDate);
                    }, //Todo: Save User Input
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: model.save
                            ? action == 'credit'
                                ? BrandColors.secondary
                                : BrandColors.primary
                            : action == 'credit'
                                ? BrandColors.secondary.withOpacity(0.5)
                                : BrandColors.primary.withOpacity(0.5),
                      ),
                      width: width,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).save,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: ScreenUtil().setSp(16),
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        viewModelBuilder: () => AddDebtCreditViewModel());
  }
}
