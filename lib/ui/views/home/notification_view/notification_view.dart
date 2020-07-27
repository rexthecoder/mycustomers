import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
        onModelReady: (model) {
          model.getlogs();
          model.getReminders();
        },
        builder: (context, model, child) => DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: customizeAppBar(context, 0.0,
                      title: AppLocalizations.of(context).notifications,
                      arrowColor: BrandColors.primary,
                      backgroundColor: Theme.of(context).backgroundColor),
                  body: Column(
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 1),
                          unselectedLabelColor: Theme.of(context).cursorColor,
                          labelColor: Theme.of(context).buttonColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Theme.of(context).buttonColor,
                          tabs: [
                            Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).reminders,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.yMargin(context, 2),
                                    ),
                                    //maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context).activities,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.yMargin(context, 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            model.reminders.length == 0
                                ? Container(
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .noRemindersYet,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.yMargin(context, 2)),
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (var item in model.reminders)
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color(
                                                            0xFFC4C4C4)))),
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(children: <Widget>[
                                              Expanded(
                                                  child: Text(
                                                item.amount > item.paid
                                                    ? model.getName(item.cId) +
                                                        AppLocalizations.of(
                                                                context)
                                                            .debtOf +
                                                        ' ${item.amount} ' +
                                                        AppLocalizations.of(
                                                                context)
                                                            .isDueToday
                                                    : model.getName(item.cId) +
                                                        AppLocalizations.of(
                                                                context)
                                                            .creditOf +
                                                        ' ${item.paid} ' +
                                                        AppLocalizations.of(
                                                                context)
                                                            .isDueToday,
                                                style: TextStyle(
                                                    fontSize:SizeConfig.yMargin(context, 2)),
                                              )),
                                              SizedBox(width: 20.0),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF333CC1),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                      DateFormat('MMM dd yyyy')
                                                          .format(DateTime
                                                              .parse(item
                                                                  .duedate)),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:SizeConfig.yMargin(context, 2),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                          ),
                                      ],
                                    ),
                                  ),
                            model.loglist.length == 0
                                ? Center(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .noActivitiesYet,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.yMargin(context, 2)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (var log in model.loglist)
                                          Dismissible(
                                            key: Key(model.loglist
                                                .indexOf(log)
                                                .toString()),
                                            onDismissed:
                                                (DismissDirection direction) {},
                                            direction: DismissDirection.endToStart,
                                            background: Container(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              color: Colors.red,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(Icons.delete)
                                                  // Text(
                                                  //     AppLocalizations.of(context)
                                                  //         .delete,
                                                  //     style: TextStyle(
                                                  //         color: Colors.white)),
                                                  ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color(
                                                              0xFFC4C4C4)))),
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(children: <Widget>[
                                                    Expanded(
                                                        child: Text(
                                                      log.description,
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                              .yMargin(
                                                                  context, 2)),
                                                    )),
                                                    SizedBox(width: 20.0),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          '',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF333CC1),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Text(
                                                            log.timestamp.day ==
                                                                    DateTime.now()
                                                                        .day
                                                                ? DateFormat(
                                                                        'hh:mm aa')
                                                                    .format(log
                                                                        .timestamp)
                                                                : DateFormat(
                                                                        'MMM dd yyyy')
                                                                    .format(log
                                                                        .timestamp),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:SizeConfig.yMargin(context, 2),
                                                            )),
                                                      ],
                                                    ),
                                                  ])
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
        viewModelBuilder: () => NotificationViewModel());
  }
}
