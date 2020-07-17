import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      onModelReady: (model) => model.getlogs(),
        builder: (context, model, child) => DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: customizeAppBar(context, 0.0,
                  title: "Notifications", arrowColor: BrandColors.primary),
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
                                "Reminders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.yMargin(context, 1.5),
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
                                "Activities",
                                textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontSize: SizeConfig.yMargin(context, 1.5),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(),
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              for(var log in model.loglist) Dismissible(
                                key: Key(model.loglist.indexOf(log).toString()),
                                onDismissed: (DismissDirection direction) {
                                  
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: EdgeInsets.only(right: 15),
                                  color: BrandColors.primary,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        Text('View', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Expanded(
                                            child: Text(log.description)),
                                        SizedBox(width: 20.0),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF333CC1),
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('time',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
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
              )
            ),
        ),
        viewModelBuilder: () => NotificationViewModel());
  }
}
