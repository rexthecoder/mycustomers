import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:mycustomers/ui/views/home/pdf/pdfViewerScreen_view.dart';
import 'package:stacked/stacked.dart';

class SavedDialog extends StatelessWidget {

  showSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(350),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/blue_mark.svg'
                ),
                Text(
                  'Saved',
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18),),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  showPdfDialog(BuildContext context, DateTime start, DateTime stop) {
    showDialog(
      context: context,
      builder: (BuildContext dcontext) => ViewModelBuilder<MainTransactionViewModel>.reactive(
        builder: (context, model, child) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5), horizontal: SizeConfig.xMargin(context, 6)),
          width: SizeConfig.xMargin(context, 100),
          height: SizeConfig.yMargin(context, 100)*0.48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).backgroundColor),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: ScreenUtil.screenWidth,
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5)),
                  margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 1.5)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF575A65), width: 0.35)
                    )
                  ),
                  child: Text(
                    'Export as PDF',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2.4),
                      color: BrandColors.primary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 1.5)),
                  child: Text(
                    'From',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final DateTime picked =
                        await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: start,
                      lastDate: stop,
                      builder: (BuildContext
                              context,
                          Widget child) {
                        return Theme(
                          data: Theme.of(
                                  context)
                              .copyWith(
                            primaryColor: Theme.of(
                                        context)
                                    .textSelectionColor,
                            accentColor: Theme.of(
                                        context)
                                    .textSelectionColor,
                            colorScheme: Theme.of(
                                    context)
                                .colorScheme
                                .copyWith(
                                    primary: Theme.of(context).textSelectionColor),
                            buttonTheme: ButtonThemeData(
                                textTheme:
                                    ButtonTextTheme
                                        .primary),
                          ),
                          child: child,
                        );
                      },
                    );
                    if (picked != null)
                      model.setReportStart(picked);},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.8), horizontal: SizeConfig.xMargin(context, 5)),
                    decoration: BoxDecoration(
                      border: Border.all(color: model.reportstarterr ? Colors.red : Color(0xFF575A65)),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          model.reportstart != null ? model.dformat.format(model.reportstart) : 'Select Start Date'
                        ),
                        SvgPicture.asset('assets/images/pdf_calendar.svg')
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 1.5)),
                  child: Text(
                    'To',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final DateTime picked =
                        await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: start,
                      lastDate: stop,
                      builder: (BuildContext
                              context,
                          Widget child) {
                        return Theme(
                          data: Theme.of(
                                  context)
                              .copyWith(
                            primaryColor: Theme.of(
                                        context)
                                    .textSelectionColor,
                            accentColor: Theme.of(
                                        context)
                                    .textSelectionColor,
                            colorScheme: Theme.of(
                                    context)
                                .colorScheme
                                .copyWith(
                                    primary: Theme.of(context).textSelectionColor),
                            buttonTheme: ButtonThemeData(
                                textTheme:
                                    ButtonTextTheme
                                        .primary),
                          ),
                          child: child,
                        );
                      },
                    );
                    if (picked != null)
                      model.setReportStop(picked);},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.8), horizontal: SizeConfig.xMargin(context, 5)),
                    decoration: BoxDecoration(
                      border: Border.all(color: model.reportstoperr ? Colors.red : Color(0xFF575A65)),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          model.reportstop != null ? model.dformat.format(model.reportstop)  : 'Select Stop Date'
                        ),
                        SvgPicture.asset('assets/images/pdf_calendar.svg')
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 2.4),),
                Container(
                  padding: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 1.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pop(dcontext);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.8), horizontal: SizeConfig.xMargin(context, 8)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFA7A6A6)
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          if(model.reportstart == null || model.reportstop ==null) {
                            model.setreportdialogerror();
                          }else {
                            model.getPdf(context);
                            Navigator.of(dcontext).pop();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.8), horizontal: SizeConfig.xMargin(context, 8)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: BrandColors.primary
                          ),
                          child: Center(
                            child: Text(
                              'Export',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        )
      ),
      viewModelBuilder: () => MainTransactionViewModel(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}