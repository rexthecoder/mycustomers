import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'message_viewmodel.dart';

import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_viewmodel.dart';

import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';

class MessageView extends StatelessWidget {
  final MessageArgument arguments;
  MessageView(this.arguments);
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) {
        model.setQuickText(arguments.title, arguments.message);
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendAMessage,
              arrowColor: BrandColors.primary,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  SizedBox(
//                    height: 20.h,
//                  ),
//                  Text(AppLocalizations.of(context).title),
//                  SizedBox(
//                    height: 10.h,
//                  ),
//                  TextField(
//                    textCapitalization: TextCapitalization.sentences,
//                    controller: model.titleController,
//                    decoration: InputDecoration(
//                      hintText:
//                          AppLocalizations.of(context).enterTitleOfMessage,
//                      hintStyle: TextStyle(fontSize: 16.sp),
//                      border: OutlineInputBorder(
//                          borderSide: BorderSide(color: ThemeColors.gray)),
//                      focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: BrandColors.secondary)),
//                      contentPadding: const EdgeInsets.symmetric(
//                          horizontal: 20, vertical: 10),
//                    ),
////                      maxLines: 2,
//                    onChanged: model.setTitle,
//                    textInputAction: TextInputAction.next,
//                  ),
                  SizedBox(
                    height:  SizeConfig.yMargin(context, 1),
                  ),
                  //TODO: fix Message Localization
                  Text(AppLocalizations.of(context).message,style: TextStyle(
                    fontSize:  SizeConfig.textSize(context, 4),
                  ),),
                  SizedBox(
                    height:  SizeConfig.yMargin(context, 1),
                  ),
                  TextField(

                    style: TextStyle(fontSize:  SizeConfig.textSize(context, 4)),
                    textCapitalization: TextCapitalization.sentences,
                    controller: model.messageController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).enterMessage,

                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.gray)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BrandColors.secondary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    maxLines: 8,
                    onChanged: model.setBody,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height:  SizeConfig.yMargin(context, 1),
                  ),
                  Container(
                    height: SizeConfig.yMargin(context, 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: ThemeColors.gray),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              model.selectedCustomers.length == 1
                                  ? '${model.selectedCustomers.length} ' +
                                      AppLocalizations.of(context)
                                          .selectedCustomer
                                  : '${model.selectedCustomers.length} ' +
                                      AppLocalizations.of(context)
                                          .selectedCustomer +
                                      's',
                              style: TextStyle(
                                  fontSize: SizeConfig.textSize(context, 4.3)),
                            ),
                            Flexible(
                              child: FlatButton.icon(
                                onPressed: () async {
                                  final bool isPermitted =
                                      await model.checkPermission();
                                  if (!isPermitted) {
                                    permissionDialog(context, model);
                                  } else {
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
                                        return BottomSheetView(
                                            SizeConfig.yMargin(context, 50),
                                            model);
                                      },
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.add,
                                  size:  SizeConfig.xMargin(context, 5),
                                  color: BrandColors.primary,
                                ),
                                label: Text(
                                  AppLocalizations.of(context).add,
                                  style: TextStyle(
                                    fontSize: SizeConfig.textSize(context, 4),
                                    color: BrandColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: model.selectedCustomers.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.yMargin(context, 1.5)),
                              child: Row(
                                children: <Widget>[
                                  CustomerCircleAvatar(
                                    ccustomer: model.selectedCustomers[index],
                                    action: 'debtor',
                                  ),
                                  SizedBox(
                                    width: SizeConfig.xMargin(context, 5),
                                  ),
                                  Text(model.selectedCustomers[index].name,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textSize(context, 4))),
                                ],
                              ),
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
                      onPressed: () async {
                        model.send();
                        successDialog(context, model);
                      },
                      color: BrandColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).send,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:  SizeConfig.textSize(context, 4),
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
      onModelReady: (model) {
        Future.microtask(model.init);
      },
    );
  }


  Future<void> permissionDialog(
      BuildContext context, MessageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF333CC1),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      AppLocalizations.of(context).accessDenied,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textSize(context, 4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .myCustomerNeedsAccessToYourContacts,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textSize(context, 4),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 4),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              flusher(
                                  AppLocalizations.of(context)
                                      .youDeniedPermissionToYourContacts,
                                  context);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).deny,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: SizeConfig.textSize(context, 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.xMargin(context, 1),
                      ),
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              model.requestPermission();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).allow,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: SizeConfig.textSize(context, 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> successDialog(
      BuildContext context, MessageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
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
                      color: Colors.white,
                      size: SizeConfig.xMargin(context, 8),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  ),
                  Container(
                    child: Text(
                      AppLocalizations.of(context).messageSent,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textSize(context, 4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 8),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        model.returnHome();
                      },
                      child: Container(
                        height: 50,
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
                                fontSize: SizeConfig.textSize(context, 4),
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
        barrierDismissible: true,
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
                      size: SizeConfig.xMargin(context, 8),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  ),
                  Container(
                    child: Text(
                      AppLocalizations.of(context).failedToSend,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textSize(context, 4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 8),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        //route to screen
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).retry,
                              style: TextStyle(
                                color: Color(0xFF333CC1),
                                fontSize: SizeConfig.textSize(context, 4),
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

class BottomSheetView extends StatelessWidget {
  final double height;
  final MessageViewModel parentModel;
  BottomSheetView(this.height, this.parentModel);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) {
        return Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.xMargin(context, 5),
            right: SizeConfig.xMargin(context, 5),
            top: SizeConfig.yMargin(context, 2),
          ),
          child: Container(
            height: height,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).selectContacts,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 4),
                      ),),
                    FlatButton(
                      color: const Color(0xFFDEE9FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context).done,
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3.8),
                          color: BrandColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.yMargin(context, 1),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.gray.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: model.searchController,
                          style: TextStyle(
                            fontSize: SizeConfig.textSize(context, 4),
                          ),
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context).typeCustomerName,
                            prefixIcon: Icon(Icons.search, size: SizeConfig.xMargin(context, 5),),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                            focusColor: Colors.transparent,
                          ),
                          onChanged: model.search,
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      Expanded(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Container(
                                width: double.infinity,
                                height:SizeConfig.yMargin(context, 5),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).backgroundColor
                                    : ThemeColors.gray.shade400,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .phoneContacts
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600,
                                          fontSize: SizeConfig.textSize(context, 4),),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox( height: SizeConfig.yMargin(context, 1),)),
                            model.isLoadBusy /* || !model.dataReady*/
                                ? SliverToBoxAdapter(
                                    child: Center(
                                      child: LoadingAnimation(),
                                    ),
                                  )
                                : SliverPadding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          Customer customer =
                                              model.allCustomers[index];
                                          bool _isSelected =
                                              model.checkselected(
                                                  customer.displayName,
                                                  customer.phone);
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 10),
                                            child: Row(
                                              children: <Widget>[
                                                CustomerCircleAvatar(
                                                  customer: customer,
                                                  action: 'debtor',
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30),
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
                                                            fontSize:SizeConfig.textSize(context, 4),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig.yMargin(context, 0.8),
                                                        ),
                                                        Text(
                                                          '${customer.phone}',
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .gray.shade600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: SizeConfig.textSize(context, 4),
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
                                                          ? model.deselect(
                                                              customer)
                                                          : model
                                                              .select(customer);
                                                    })
                                              ],
                                            ),
                                          );
                                        },
                                        childCount: model.allCustomers.length,
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
            ),
          ),
        );
      },
      onModelReady: (model) {
        model.init();
      },
    );
  }
}
