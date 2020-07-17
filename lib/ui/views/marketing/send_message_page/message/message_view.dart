import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'message_viewmodel.dart';

import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/core/models/customer.dart';

import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';

import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';

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
          appBar: customizeAppBar(context, 1.0,
              title: 'Send a Message', arrowColor: BrandColors.secondary),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  Text( AppLocalizations.of(context).title),
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
                  Text( AppLocalizations.of(context).message),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              onPressed: () {_displayBusinessCardModal(context, model, height);},
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
                              customer: selectedCustomers[index],
                              action: 'debtor',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                    child: FlatButton(
                      onPressed: () {
//                        model.navigateToSendMessage();
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
                             AppLocalizations.of(context).send,
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

  void _displayBusinessCardModal(context, model,height) {

    showModalBottomSheet(
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.xMargin(context, 5),
            right: SizeConfig.xMargin(context, 5),
            top: SizeConfig.yMargin(context, 2),
          ),
          child: Container(
            height: height/2,
            child: Column(
//              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Select contacts'),
                    FlatButton(
                      color: const Color(0xFFDEE9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: (){},
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3.5),
                          color: BrandColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
//                      model.searchController.text != null
//                          ? model.searchedCustomer.length
//                          :
                      model.allCustomers.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        Customer customer =
//                        model.searchController.text != null
//                            ? model.searchedCustomer[index]
//                            :
                        model.allCustomers[index];
                        bool _isSelected =
                        model.isSelected(customer);
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          child: Row(
                            children: <Widget>[
                              CustomerCircleAvatar(
                                customer: customer,
                                action: 'debtor',
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30.w),
                                  child: Column(
                                    mainAxisSize:
                                    MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        '${customer.name} '
                                            '${customer.lastName}',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      Text(
                                        '${customer.phone}',
                                        style: TextStyle(
                                          color: ThemeColors
                                              .gray.shade600,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Checkbox(
                                  activeColor:
                                  BrandColors.primary,
                                  value: _isSelected,
                                  onChanged: (value) {
                                    _isSelected
                                        ? model
                                        .deselectCustomer(
                                        customer)
                                        : model.addCustomer(
                                        customer);
                                  })
                            ],
                          ),
                        );
                      }),
                    ),
//                Expanded(
//                  child: ListView.builder(
//                    itemCount: selectedCustomers.length,
//                    itemBuilder: (BuildContext context, int index) =>
//                        CustomerCircleAvatar(
//                          customer: selectedCustomers[index],
//                          action: 'debtor',
//                        ),
//                  ),
//                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> successDialog(
      BuildContext context, MessageViewModel model) async {
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
                       AppLocalizations.of(context).messageSent,
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
                               AppLocalizations.of(context).continueButton,
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
