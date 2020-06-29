import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/views/business/settings_page/select_language/select_language_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SelectLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SelectLanguageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'Language',
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
                            'Select your language',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18), color: Colors.black),
                          ),
                        ),
                        for(var lang in model.langs) langTile(context, lang['name'], lang['selected'], model, model.langs.indexOf(lang)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: InkWell(
                    onTap: (){
                      //Todo: Save Language Setting Information
                      showQuotesDialog(context);
                    },
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
      viewModelBuilder: () => SelectLanguageViewModel()
    );
  }

  showQuotesDialog(BuildContext context) {
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
          height: ScreenUtil().setHeight(400),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                  child: SvgPicture.asset(
                    'assets/icons/blue_mark.svg',
                    width: ScreenUtil().setWidth(60),
                  ),
                ),
                Text(
                  'Saved',
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  Container langTile(BuildContext context, String text, bool selected, SelectLanguageViewModel model, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: selected ? Color(0xFF333CC1) : Color(0xFFE8E8E8), width: 1.0)
      ),
      child: ListTile(
        onTap: () {
          model.selectLang(index);
        },
        leading: Container(
          width: ScreenUtil().setWidth(60),
          height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: AssetImage('assets/images/$text.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18), color: Colors.black,)
          ),
        ),
      )
    );
  }
}