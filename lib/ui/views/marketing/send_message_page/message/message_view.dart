import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'message_viewmodel.dart';

import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/core/models/customer.dart';

import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';

class MessageView extends StatelessWidget {
  final List<Customer> selectedCustomers;
  MessageView(this.selectedCustomers);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      height: height,
      width: width,
    );
    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 'Send a Message', 1.0),
//           AppBar(
//             title: Center(
//               child: Text(
//                 'Send a Message',
// //                textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                 ),
//               ),
//             ),
//           ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Title'),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter Title of message',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.gray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BrandColors.secondary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
//                      maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Message'),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    controller: model.messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      hintStyle: TextStyle(fontSize: 16.sp),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.gray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BrandColors.secondary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: ThemeColors.gray),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              selectedCustomers.length == 1
                                  ? '${selectedCustomers.length} Selected Customer'
                                  : '${selectedCustomers.length} Selected Customers',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: BrandColors.primary,
                              ),
                              label: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: BrandColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedCustomers.length,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomerCircleAvatar(
                                    customer: selectedCustomers[index],action: 'debtor',),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                    child: FlatButton(
                      onPressed: (){
                          successDialog(context, model);
                        },
                      color: BrandColors.secondary,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: width,
                        child: Center(
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    
  }
//  Widget build(BuildContext context) {
//    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);
//    return ViewModelBuilder<MessageViewModel>.reactive(
//      viewModelBuilder: () => MessageViewModel(),
//      builder: (context, model, child) {
//        return Scaffold(
//          backgroundColor: bgColor,
//          body: SingleChildScrollView(
//            child: Container(
//              height: MediaQuery.of(context).size.height,
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  SizedBox(
//                    height: 50.h,
//                  ),
//                  Container(
//                    padding: EdgeInsets.symmetric(horizontal: 30.w),
//                    height: 120.h,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        IconButton(
//                          onPressed: () {
//                            model.navigateTo();
//                          }, // TODO: implement back button
//                          icon: Icon(
//                            Icons.keyboard_backspace,
//                            color: color,
//                          ),
//                        ),
//                        Spacer(),
//                        Text(
//                          'Send a Message',
//                          style: TextStyle(
//                            fontSize: 35.sp,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        Spacer(flex: 2),
//                      ],
//                    ),
//                  ),
//                  Divider(),
//                  Container(
//                    margin: EdgeInsets.only(
//                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
//                    child: TextField(
//                      decoration: InputDecoration(
//                          fillColor: null,
//                          filled: true,
//                          enabledBorder: OutlineInputBorder(
//                            borderSide:
//                                BorderSide(color: outlineColor, width: 2.0),
//                          ),
//                          focusedBorder: OutlineInputBorder(
//                            borderSide: BorderSide(color: color, width: 2.0),
//                          )),
//                      textCapitalization: TextCapitalization.sentences,
//                      style:
//                          TextStyle(color: Colors.grey[600], fontSize: 30.sp),
//                    ),
//                  ),
//                  Container(
//                    margin: EdgeInsets.only(
//                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
//                    child: TextField(
//                      decoration: InputDecoration(
//                        enabledBorder: OutlineInputBorder(
//                          borderSide:
//                              BorderSide(color: outlineColor, width: 2.0),
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: color, width: 2.0),
//                        ),
//                      ),
//                      textCapitalization: TextCapitalization.sentences,
//                      style:
//                          TextStyle(color: Colors.grey[600], fontSize: 30.sp),
//                      minLines: 4,
//                      maxLines: 100,
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 40.w, right: 60.w),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Checkbox(
//                          value: model.checkBoxValue,
//                          onChanged: model.checkBoxFunction(true),
//                          //tristate: true,
//                          autofocus: true,
//                          activeColor: color,
//                        ),
//                        Text(
//                          'See Templates',
//                          style: TextStyle(
//                            color: color,
//                            fontSize: 27.sp,
//                          ),
//                        ),
//                        Spacer(),
//                        Text(
//                          'Swipe to see more',
//                          style: TextStyle(
//                            fontSize: 27.sp,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Container(
//                    padding: EdgeInsets.only(
//                      left: 40.w,
//                    ),
//                    height: 100.h,
//                    child: ListView(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      children: model.templateList.map((template) {
//                        return GestureDetector(
//                          onTap: model.onTap(template),
//                          child: Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(15.sp),
//                              border: Border.all(
//                                  color: model.currentIndex ==
//                                          model.templateList.indexOf(template)
//                                      ? color
//                                      : outlineColor),
//                            ),
//                            padding: EdgeInsets.all(15.sp),
//                            margin: EdgeInsets.symmetric(horizontal: 20.sp),
//                            alignment: Alignment.centerLeft,
//                            child: Text(
//                              template,
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                color: model.currentIndex ==
//                                        model.templateList.indexOf(template)
//                                    ? color
//                                    : outlineColor,
//                              ),
//                            ),
//                          ),
//                        );
//                      }).toList(),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20.h,
//                  ),
//                  Container(
//                    margin:
//                        EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
//                    padding:
//                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(15.sp),
//                      border: Border.all(color: outlineColor),
//                    ),
//                    child: Column(
//                      children: <Widget>[
//                        Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              '${model.numberOfSelectedCustomers} Selected Customer(s)',
//                              style: TextStyle(fontSize: 25.sp),
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Icon(
//                                  Icons.add,
//                                  color: color,
//                                  size: 30.sp,
//                                ),
//                                Text(
//                                  'Add',
//                                  style: TextStyle(
//                                    color: color,
//                                    fontSize: 25.sp,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          height: 10.h,
//                        ),
//                        Container(
//                          constraints:
//                              BoxConstraints.tight(Size.fromHeight(60)),
//                          child: ListView.builder(
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: model.numberOfSelectedCustomers,
//                            itemBuilder: (context, index) => Padding(
//                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
//                              child: CircleAvatar(
//                                radius: 40.sp,
//                                backgroundColor: color,
//                                // TODO: implement customer Profile Picture
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Spacer(),
//                  Container(
//                    margin: EdgeInsets.only(left: 60.w, right: 60.w),
//                    height: 100.h,
//                    decoration: BoxDecoration(
//                      color: color,
//                      borderRadius: BorderRadius.circular(15.sp),
//                    ),
//                    child: Center(
//                      child: Text(
//                        'Send',
//                        style: TextStyle(
//                            color: bgColor,
//                            fontSize: 30.sp,
//                            fontWeight: FontWeight.w500),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 50.h,
//                  )
//                ],
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
  Future<void> successDialog(BuildContext context,MessageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // TODO: change to false
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF333CC1),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFF27AE60),
                      size: 70,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    child: Text(
                      'Message sent!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        model.returnHome();
                        //TODO: route to screen
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Continue',
                              style: TextStyle(
                                color: Color(0xFF333CC1),
                                fontSize: 16.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future<void> failureDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // TODO: change to false
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF333CC1),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 70,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    child: Text(
                      'Failed to send!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        //TODO: route to screen
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Retry',
                              style: TextStyle(
                                color: Color(0xFF333CC1),
                                fontSize: 16.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
