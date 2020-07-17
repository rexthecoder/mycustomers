import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/views/business/settings/language_settings/language_view_model.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart' as ctm;
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/widgets/shared/saved_dialog.dart';

class LanguageSelectionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<LanguagePageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: customizeAppBar(context, 1.0,
                title: AppLocalizations.of(context).language , arrowColor: BrandColors.primary),
              body: Container(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(20),
                              horizontal: ScreenUtil().setWidth(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Text(
                                   AppLocalizations.of(context).selectYourLanguage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: ScreenUtil().setSp(18),
                                          color: Theme.of(context).cursorColor),
                                ),
                              ),
                              for (var lang in model.langs)
                                langTile(
                                    context,
                                    lang['name'],
                                    lang['selected'],
                                    model,
                                    model.langs.indexOf(lang)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: ctm.CustomRaisedButton(
                            label: AppLocalizations.of(context).save,
                            onPressed: () {
                              model.saveLang();
                              Navigator.pop(context);
                              SavedDialog().showSavedDialog(context);
                            }))
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => LanguagePageViewModel());
  }

  Container langTile(BuildContext context, String text, bool selected,
      LanguagePageViewModel model, int index) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: selected
                    ? Theme.of(context).textSelectionColor
                    : Color(0xFFE8E8E8),
                width: 1.0)),
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
                )),
          ),
          title: Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Text(text,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: ScreenUtil().setSp(18),
                      color: Theme.of(context).cursorColor,
                    )),
          ),
        ));
  }
}
// }
