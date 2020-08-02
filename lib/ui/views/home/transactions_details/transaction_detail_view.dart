import 'dart:io';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';
import 'transaction_details_viewmodel.dart';
import '../../../shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';



class TransactionDetails extends StatelessWidget {
  final Color color = BrandColors.primary;
  final Color bgColor = Colors.grey[200];
  final Color containerColor = Colors.white;
  final currency = new NumberFormat("#,##0", "en_NG");
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);
    return ViewModelBuilder<TransactionDetailsViewModel>.reactive(
      viewModelBuilder: () => TransactionDetailsViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              brightness: Brightness.dark,
              backgroundColor: BrandColors.primary,
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).transactionDetails,
                style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: SizeConfig.textSize(context, 5),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: SvgPicture.asset(
                    'assets/icons/backarrow.svg',
                    color: Colors.white
                  ),
                ),
              ),
            )
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            border: Border.all(
                                color: Theme.of(context).textSelectionColor),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(
                            left: SizeConfig.xMargin(context, 5.5), right: SizeConfig.xMargin(context, 5.5), top: SizeConfig.yMargin(context, 3), bottom: 0.0),
                        width: double.infinity,
                        //height: 550.w,
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.xMargin(context, 3), vertical: SizeConfig.yMargin(context, 1.8)),
                                  child: Row(
                                    children: <Widget>[
                                      model.contact.initials != null
                                          ? CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  BrandColors.primary,
                                              child: Text(
                                                model.contact.initials,
                                                style: TextStyle(
                                                    color: Colors.white,)
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Theme.of(context)
                                                  .textSelectionColor,
                                              backgroundImage: AssetImage(
                                                  'assets/images/man.png'),
                                            ),
                                      SizedBox(
                                        width: SizeConfig.xMargin(context, 3),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                model.contact.name,
                                                style: TextStyle(
                                                  fontSize: SizeConfig.yMargin(context, 2.4),
                                                  fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ), // TODO: implement Profile picture
                                            Text(
                                              model.contact.phoneNumber,
                                              style: TextStyle(
                                                fontSize: SizeConfig.yMargin(context, 2),
                                                color: Colors.grey[600],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).textSelectionColor,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.yMargin(context, 2.8),
                                        left: SizeConfig.xMargin(context, 4.5),
                                        right: SizeConfig.xMargin(context, 4.5),
                                        bottom: SizeConfig.yMargin(context, 2.8)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Transaction ID:  ',
                                              // textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: SizeConfig.yMargin(context, 2)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.transaction.tId,
                                                // textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: SizeConfig.yMargin(context, 2)), maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.yMargin(context, 0.3),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2.1),
                                                ),
                                                Text(
                                                  'Date Recorded',
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                model.transaction.paiddate != null ? SizedBox() : Text(
                                                  'Due Date',
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, model.transaction.paiddate != null ? 0 : 2),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .costOfItems,
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .amountPaid,
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .amountOwing,
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2.1),
                                                ),
                                                Text(
                                                  model.dformat.format(DateTime.parse(model.transaction.boughtdate == null ? model.transaction.paiddate : model.transaction.boughtdate)),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionColor,
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                model.transaction.paiddate != null ? SizedBox() : Text(
                                                  model.dformat.format(DateTime.parse(model.transaction.duedate)),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionColor,
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, model.transaction.paiddate != null ? 0 : 2),
                                                ),
                                                Text(
                                                  model.transaction.amount != null
                                                      ? '₦${currency.format(model.transaction.amount)}'
                                                      : '₦0',
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionColor,
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                Text(
                                                  model.transaction.paid != null
                                                      ? '₦${currency.format(model.transaction.paid)}'
                                                      : '₦0',
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.yMargin(context, 2),
                                                ),
                                                Text(
                                                  model.transaction.amount != null &&
                                                          model.transaction.paid !=
                                                              null &&
                                                          (model.transaction.amount -
                                                                  model.transaction
                                                                      .paid) >
                                                              0
                                                      ? '₦${currency.format(model.transaction.amount - model.transaction.paid)}'
                                                      : '₦0',
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.red[800],
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig.yMargin(context, 2)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.yMargin(context, 1.6),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Description:   ',
                                              // textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: SizeConfig.yMargin(context, 2)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.transaction.description ?? '',
                                                // textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: SizeConfig.yMargin(context, 2)), maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ),
                    ),
                  ),
                ),
              SizedBox(
                height: SizeConfig.yMargin(context, 2.8),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 5)),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        model.delete();
                      },
                      child: Container(
                        height: SizeConfig.yMargin(context, 6),
                        width: SizeConfig.xMargin(context, 38),
                        decoration: BoxDecoration(
                            //color: containerColor,
                            border: Border.all(
                                color: Theme.of(context).textSelectionColor),
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).delete,
                            style: TextStyle(
                                fontSize: SizeConfig.yMargin(context, 2),
                                color: Theme.of(context).textSelectionColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        model.edit();
                      }, // TODO: implement Edit button
                      child: Container(
                        height: SizeConfig.yMargin(context, 6),
                        width: SizeConfig.xMargin(context, 38),
                        decoration: BoxDecoration(
                          color: BrandColors.primary.withOpacity(0.9),
                          //border: Border(top: BorderSide(color: Colors.blue)),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).edit,
                            style: TextStyle(
                              fontSize: SizeConfig.yMargin(context, 2),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 4),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    screenshotController
                        .capture(
                      pixelRatio: ScreenUtil.pixelRatio,
                      delay: Duration(milliseconds: 10),
                    )
                        .then(
                          (File image) {
                            model.imageFile = image;
//                        FlushbarHelper.createSuccess(
//                          duration: const Duration(seconds: 5),
//                          message: 'Sharing...',
//                        ).show(context);
                            model.shareImageAndText();
                        FlushbarHelper.createSuccess(
                          duration: const Duration(seconds: 5),
                          message: 'Preparing...',
                        ).show(context);
                      },
                    ).catchError(
                          (onError) {
                        FlushbarHelper.createError(
                          duration: const Duration(seconds: 5),
                          message: onError.toString(),
                        ).show(context);
                      },
                    );
                    return;
                  },
                  child: Container(
                    height: SizeConfig.yMargin(context, 6.5),
                    width: SizeConfig.xMargin(context, 50),
                    decoration: BoxDecoration(
                        color: BrandColors.primary,
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('assets/images/Vector.svg'),
                        SizedBox(
                          width: SizeConfig.xMargin(context, 2.8),
                        ),
                        Text(AppLocalizations.of(context).share,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.yMargin(context, 2),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}

class BottomButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const BottomButton({Key key, this.text, this.imagePath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20))),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200])),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Center(
                    child: SvgPicture.asset(
                  imagePath,
                  height: 40.h,
                  width: 40.w,
                )),
              ),
            ),
          ),
          Text(text,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 30.sp,
                  ))
        ],
      ),
    );
  }
}