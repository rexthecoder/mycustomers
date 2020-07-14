import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';


class NotificationsView extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(context, "Notifications", 1.0),
        body: ListView.builder(
          itemCount: model.notifications.length,
          itemBuilder: (context, index){
            return Dismissible(
              key: Key(index.toString()),
              onDismissed: (DismissDirection direction) {},
              direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.only(right: 15),
                color: BrandColors.primary,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'View',
                    style: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),        
                child: Column(
                  children: <Widget>[ 
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(model.notifications[index]['msg'])
                        ),
                        SizedBox(width: 20.0),                
                        Column(
                          children: <Widget>[
                            Text('N'+model.notifications[index]['price'],
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                color: Color(0xFF333CC1),
                              ),
                            ),
                              SizedBox(height: 8.0),
                            Text(model.notifications[index]['time'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              )  
                            ),
                          ],
                        ),
                      ]  
                    )
                  ],
                ),
              ),
            );
          }
        )
      ),
      viewModelBuilder: () => NotificationViewModel()
    );
  }

  
}
