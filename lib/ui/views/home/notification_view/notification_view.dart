import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Notifications extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white,
            iconTheme: IconThemeData(
            color: Color(0xFF333CC1), 
          ),
          elevation: 2.0,
          centerTitle: true,
          title: Text("Notifications",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: SvgPicture.asset(
                'assets/icons/backarrow.svg',
                color: BrandColors.primary,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: (){},
              child: Text("View",
                style: TextStyle(
                  color: Color(0xFF333CC1),
                ),
            ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: model.notifications.length,
          itemBuilder: (context, index){
            return Slidable(
              key: Key(index.toString()),
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
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  iconWidget: Container(
                    child: Text(
                      'View',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  //caption: 'View',
                  color: BrandColors.primary,
                  closeOnTap: true,
                  onTap: (){},
                )
              ],
              dismissal: SlidableDismissal(child: SlidableDrawerDismissal()),
            );
          }
        )
      ),
      viewModelBuilder: () => NotificationViewModel()
    );
  }
}