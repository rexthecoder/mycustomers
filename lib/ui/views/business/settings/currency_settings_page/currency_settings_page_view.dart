import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'currency_settings_page_viewmodel.dart';

class CurrencySettingsPageView extends StatelessWidget {
  final List<String> imageList = [
    'assets/icons/svg/naira.svg',
    'assets/icons/svg/dollars.svg',
    'assets/icons/svg/indian_rubies.svg',
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720);
    return ViewModelBuilder<CurrencySettingsPageViewModel>.reactive(
      viewModelBuilder: () => CurrencySettingsPageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Currency',
              style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.yMargin(context, 2),
                    horizontal: SizeConfig.xMargin(context, 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select your language',
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 3.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 2),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var currency = model.currencies[index];
                            var imageIcon = imageList[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                                // TODO Add border on selected
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(15, 71, 126, 200),
                                    offset: Offset(5, 5),
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  // TODO Save Currency
                                },
                                leading: CircleAvatar(
                                  // TODO change background on selected
                                  backgroundColor: Color(0xFFD1D1D1),
                                  minRadius: SizeConfig.xMargin(context, 5),
                                  maxRadius: SizeConfig.xMargin(context, 6),
                                  child: SvgPicture.asset(
                                    imageIcon,
                                    semanticsLabel: currency.currency,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  currency.currency,
                                  style: TextStyle(
                                    fontSize: SizeConfig.textSize(context, 4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: model.currencies.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: SizeConfig.yMargin(context, 3),
                            );
                          },
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Color(0xFF333CC1),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.yMargin(context, 2.5),
                          horizontal: SizeConfig.xMargin(context, 40),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
