import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'language_viewmodel.dart';

class LanguageView extends StatelessWidget {
  SizeConfig config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) => Material(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: height * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding/ob1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: config.yMargin(context, 20)),
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.05),
                    topRight: Radius.circular(height * 0.05),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: config.yMargin(context, 7)),
                    Text(
                      'LANGUAGE',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: config.yMargin(context, 4),
                      ),
                    ),
                    SizedBox(height: config.yMargin(context, 4)),
                    Text(
                      'Select your language',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: config.yMargin(context, 3),
                      ),
                    ),
                    SizedBox(height: config.yMargin(context, 0.2)),
                    Container(
                      height: config.yMargin(context, 40),
                      width: config.xMargin(context, 90),
                      child: ListView.builder(
                        itemCount: model.languages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(config.yMargin(context, 1)),
                            child: InkWell(
                              onTap: () {
                                model.setLanguage(index);
                              },
                              child: Container(
                                height: config.yMargin(context, 10),
                                width: config.xMargin(context, 100),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(
                                          config.yMargin(context, 1)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            config.yMargin(context, 5)),
                                        child: Image(
                                          height: config.yMargin(context, 10),
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
                                        fontSize: config.yMargin(context, 2),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          config.yMargin(context, 3)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF333333),
                                        size: config.yMargin(context, 2),
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
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LanguageViewModel(),
    );
  }
}
