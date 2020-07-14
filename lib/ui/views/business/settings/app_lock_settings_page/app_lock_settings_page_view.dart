import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'app_lock_settings_page_viewmodel.dart';

class AppLockSettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppLockSettingsPageViewModel>.reactive(
      viewModelBuilder: () => AppLockSettingsPageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'App Lock',
              style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 5),
                  fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(18),
                        vertical: ScreenUtil().setHeight(10)),
                    child: SvgPicture.asset(
                      'assets/icons/backarrow.svg',
                      color: Theme.of(context).textSelectionColor,
                    ),
                  ),
                ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
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
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 196, 196, 196),
                        ),
                        child: ListTileTheme(
                          style: ListTileStyle.list,
                          selectedColor:
                              const Color.fromARGB(50, 196, 196, 196),
                          child: ListTile(
                            onTap: () => model.getThecurrentStateOfPin() == false ? model.navigateToSetPinPage() :
                            model.navigateToChangePinPage(),
                            trailing: Icon(Icons.chevron_right),
                            title:model.getThecurrentStateOfPin() == false ? Text(
                              'Set App lock Pin',
                              style: TextStyle(
                                fontSize: SizeConfig.textSize(context, 4),
                                fontWeight: FontWeight.w600,
                              ),
                            ) 
                            : Text(
                              'Change App lock Pin',
                              style:TextStyle(
                                fontSize:SizeConfig.textSize(context, 4),
                                fontWeight: FontWeight.w600
                                 )
                            )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 2.5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 196, 196, 196),
                        ),
                        child: ListTileTheme(
                          style: ListTileStyle.list,
                          selectedColor:
                              const Color.fromARGB(50, 196, 196, 196),
                          child: ListTile(
                            enabled: model.getThecurrentStateOfPin(),
                            onTap: () => model.navigateToRemovePinPage(),
                            trailing: Icon(Icons.chevron_right),
                            title: Text(
                              'Remove App lock',
                              style: TextStyle(
                                fontSize: SizeConfig.textSize(context, 4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
