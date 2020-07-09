import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/settings/currency_settings_page/currency_settings_page_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
import 'package:mycustomers/ui/widgets/shared/saved_dialog.dart';
import 'package:stacked/stacked.dart';

class CurrencySettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<CurrencySettingPageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'Currency',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w900, color: Colors.black,),
          ),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(18), vertical: ScreenUtil().setHeight(10)),
              child: SvgPicture.asset(
                'assets/icons/backarrow.svg'
              ),
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20), horizontal: ScreenUtil().setWidth(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Select your currency',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig.yMargin(context, 2.7), color: Colors.black),
                          ),
                        ),
                        for(var curr in model.currencies) currTile(context, curr['name'], curr['selected'], model, model.currencies.indexOf(curr)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: CustomRaisedButton(
                  label: 'Save',
                  onPressed: (){
                    model.saveCurrencyIndex();
                    Navigator.pop(context);
                    SavedDialog().showSavedDialog(context);
                  }
                )
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => CurrencySettingPageViewModel()
    );
  }

  

  Container currTile(BuildContext context, String text, bool selected, CurrencySettingPageViewModel model, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: selected ? Color(0xFF333CC1) : Color(0xFFE8E8E8), width: 1.0)
      ),
      child: ListTile(
        onTap: () {
          model.selectCurrency(index);
        },
        leading: Container(
          width: ScreenUtil().setWidth(55),
          height: ScreenUtil().setHeight(55),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            color: selected ? Color(0xFF219653) : Color(0xFFD1D1D1)
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/$text.svg'
            ),
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(left: 30),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig.yMargin(context, 2.6), color: Colors.black,)
          ),
        ),
      )
    );
  }
}