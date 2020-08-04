import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/message_history/message_history_viewmodel.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:stacked/stacked.dart';

class MessageHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageHistoryViewModel>.reactive(
        onModelReady: (model) => model.getMessages(),
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 15)),
              child: AppBar(
                brightness: Brightness.dark,
                elevation: 0.0,
                title: Container(
                  margin:
                      EdgeInsets.only(right: SizeConfig.xMargin(context, 2), top: 6),
                  child: Row(
                    children: <Widget>[
                      CustomerCircleAvatar(
                        ccustomer: model.customer,
                      ),
                      SizedBox(
                        width: SizeConfig.xMargin(context, 2),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                model.customer.name ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.yMargin(context, 2.4),
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: Text(
                                model.customer.phoneNumber ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.yMargin(context, 1.8),
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                leading: InkWell(
                  onTap: () => model.popView(),
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg',
                      color: Colors.white,
                      height: SizeConfig.yMargin(context, 2),
                      width: SizeConfig.xMargin(context, 4),
                    ),
                  ),
                ),
                actionsIconTheme:
                    IconThemeData(color: Theme.of(context).cursorColor),
                backgroundColor: BrandColors.primary,
                centerTitle: true,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 8)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:SizeConfig.xMargin(context, 3),
                          vertical: SizeConfig.yMargin(context, 1.5)),
                      height: SizeConfig.yMargin(context, 8),
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: SizeConfig.yMargin(context, 8),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              model.navigateToTransaction();
                            },
                            child: Center(
                                child: Text(
                              'View Transactions',
                              style: TextStyle(
                                  color: BrandColors.primary,
                                  fontSize: SizeConfig.textSize(context, 4),
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin:  EdgeInsets.only( bottom: SizeConfig.yMargin(context, 18)+5,top: 5, left:  SizeConfig.xMargin(context, 25), right: 20),
//                  child: ListView.builder(
//                      itemCount: model.messages.length,
//                      itemBuilder: (BuildContext context, int index) =>
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              Flexible(
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                    borderRadius:
//                                    BorderRadius.circular(5),
//                                    color: ThemeColors.gray[800].withOpacity(0.5),
//                                  ),
//                                  padding: const EdgeInsets.all(5.0),
//                                  margin:  EdgeInsets.only(
//                                      top: 5, bottom: 5, left:  SizeConfig.xMargin(context, 25), right: 20),
//                                  child: Text(
//                                  model.messages[index].message ?? '',
//                                  textAlign: TextAlign.end,
//                                  ),
//                                ),
//                              ),
//                            ],
//                          )),

                      child:ListView(
                        reverse: true,
                        children:  model.messagesReversed.map<Row>((e) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.only(
                                        topLeft:  Radius.circular(10),
                                        bottomRight:  Radius.circular(10),
                                        bottomLeft:  Radius.circular(10)
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.only(
                                        topLeft:  Radius.circular(10),
                                        bottomRight:  Radius.circular(10),
                                        bottomLeft:  Radius.circular(10)
                                      ),
                                      color: ThemeColors.gray[800].withOpacity(0.5),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
//                            margin:  EdgeInsets.only(
//                                top: 5, bottom: 5, left:  SizeConfig.xMargin(context, 25), right: 20),
                                    child: Text(
                                      e.message ?? '',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: SizeConfig.textSize(context, 3.5)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )).toList(),),
                      ),
                    ),
                    SizedBox(
                      height:  MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 0,
                  right: 0,
                  child: Container(
                    height:  SizeConfig.yMargin(context, 18),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            vertical: BorderSide(color: ThemeColors.gray[700])),
                        color: Theme.of(context).backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: model.dummyQuickText.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            color: BrandColors.primary
                                                .withOpacity(0.3),
                                            onPressed: () => model.setText(
                                                model.dummyQuickText[index]),
                                            child: Container(
                                                height:  SizeConfig.yMargin(context, 6),
                                                child: Center(
                                                    child: Text(
                                                        model.dummyQuickText[
                                                            index],
                                                    style: TextStyle(
                                                      fontSize: SizeConfig.textSize(context, 3.5)
                                                    ),)))),
                                      ),
                                    )),
                          ),
                          SizedBox( height:  SizeConfig.yMargin(context, 2),),
                          Container(
                            height:  SizeConfig.yMargin(context, 8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: model.messageController,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                        fontSize: SizeConfig.textSize(context, 3.5)
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                    hintText: AppLocalizations.of(context).startTypingYourmessage
                                    ),
                                    onChanged: model.updatetext,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.xMargin(context, 2)
                                ),
                                InkWell(
                                  onTap: () {
                                    model.send();
                                  },
                                  child: Container(
                                    width:  SizeConfig.xMargin(context, 8),
                                    height: SizeConfig.xMargin(context, 8),
                                    decoration: BoxDecoration(
                                      color: BrandColors.primary,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: SizeConfig.xMargin(context, 4),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => MessageHistoryViewModel());
  }
}
