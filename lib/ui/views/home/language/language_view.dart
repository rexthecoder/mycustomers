import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'language_viewmodel.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomBackground(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.yMargin(context, 7)),
              Text(
                AppLocalizations.of(context).language.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: SizeConfig.yMargin(context, 4),
                ),
              ),
              SizedBox(height: SizeConfig.xMargin(context, 4)),
              Text(
                AppLocalizations.of(context).selectYourLanguage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.yMargin(context, 2),
                ),
              ),
              SizedBox(height: SizeConfig.yMargin(context, 0.2)),
              Container(
                height: SizeConfig.yMargin(context, 60),
                width: SizeConfig.xMargin(context, 90),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(SizeConfig.yMargin(context, 1)),
                      child: InkWell(
                        onTap: () {
                          //TODO: Uncomment
                          model.setLanguage(index);
                        },
                        child: Container(
                          height: SizeConfig.yMargin(context, 10),
                          width: SizeConfig.xMargin(context, 100),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(13, 71, 126, 200),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0xFFE8E8E8),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.yMargin(context, 1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.yMargin(context, 5)),
                                  child: Image(
                                    height: SizeConfig.yMargin(context, 10),
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      model.languages[index]['image'],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                model.languages[index]['name'],
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: SizeConfig.yMargin(context, 2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.yMargin(context, 3)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF333333),
                                  size: SizeConfig.yMargin(context, 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LanguageViewModel(),
    );
  }
}
