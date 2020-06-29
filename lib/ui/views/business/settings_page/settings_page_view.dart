import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/views/business/settings_page/select_currency/select_currency_viewmodel.dart';
import 'package:mycustomers/ui/views/business/settings_page/select_language/select_language_viewmodel.dart';
import 'package:mycustomers/ui/views/business/settings_page/settings_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SettingsPageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'Settings',
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
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      cardTile('Change Language', SelectLanguageViewModel().langs[SelectLanguageViewModel().index]['name'], model.navigateToLanguage, context),
                      cardTile('Change Currency', SelectCurrencyViewModel().currencies[SelectCurrencyViewModel().index]['name'], model.navigateToCurrency, context),
                      cardTile('App Lock', '', model.navigateToAppLock, context),
                      SizedBox(height: ScreenUtil().setHeight(50),),
                      switchTile(context, model.notification, model.setNotification, 'Recieve Notifications'),
                      switchTile(context, model.newsletter, model.setNewsletter, 'Recieve NewsLetter'),
                      switchTile(context, model.special, model.setSpecial, 'Recieve Special Offers'),
                      switchTile(context, model.update, model.setUpdate, 'Recieve Updates'),
                    ],
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFF333CC1),
                      ),
                      width: width,
                      child: Center(
                        child: Text(
                          'Save',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(16), color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SettingsPageViewModel()
    );
  }

  Container cardTile(String text, String subtext, Function func, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: ScreenUtil().setWidth(1.0), color: Color(0xFFE5E5EE))
        )
      ),
      child: ListTile(
        onTap: func,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18), color: Colors.black,),
            ),
            Text(
              subtext ?? '', 
              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(12), color: Color(0xFF595959),),
            )
          ],
        ),
        trailing: SvgPicture.asset(
          'assets/icons/arrow_right.svg'
        ),
      )
    );
  }

  Container switchTile(BuildContext context, bool value, Function func, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(3)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: ScreenUtil().setWidth(1.0), color: Color(0xFFE5E5EE).withOpacity(0.1))
        )
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(16), color: Color(0xFF595959),),
            )
          ],
        ),
        trailing: InkWell(
          onTap: func,
          child: Container(
            height: ScreenUtil().setHeight(33),
            width: ScreenUtil().setHeight(55),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: value ? Color(0xFF333CC1) : Color(0xFFD1D1D1)
            ),
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  top: ScreenUtil().setHeight(2.4),
                  left: value ? ScreenUtil().setWidth(25.0) : ScreenUtil().setWidth(3.0),
                  right: value ? ScreenUtil().setWidth(3.0) : ScreenUtil().setWidth(25.0),
                  child: Container(
                    width: ScreenUtil().setWidth(28),
                    height: ScreenUtil().setHeight(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}