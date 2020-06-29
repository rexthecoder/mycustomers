import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/views/business/settings_page/applock/applock_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AppLockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<AppLockViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          title: Text(
            'App Lock',
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              cardTile('Change App lock PIN', (){
                //Todo: Navigate to Change Pin Screen
              }, context),
              cardTile('Remove App lock PIN', (){
                //Todo: Remove Lock pin
              }, context),
            ],
          )
        ),
      ),
      viewModelBuilder: () => AppLockViewModel()
    );
  }

  Container cardTile(String text, Function func, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      /*decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: ScreenUtil().setWidth(1.0), color: Color(0xFFE5E5EE))
        )
      ),*/
      child: ListTile(
        onTap: func,
        title: Text(
          text,
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18), color: Colors.black,),
        ),
        trailing: SvgPicture.asset(
          'assets/icons/arrow_right.svg'
        ),
      )
    );
  }
}