import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/views/home/home_page/tabs/debtors_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'home_page_viewmodel.dart';
import 'tabs/creditors_view.dart';

class HomePageView extends StatelessWidget {
  //TODO: Position notification bell dot properly

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model){
        model.getContacts();
        model.getTransactions();
      },
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey, width: 0.5))),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    unselectedLabelColor: Colors.black,
                    labelColor: model.tabNo == 1 ? BrandColors.secondary :  BrandColors.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: model.tabNo == 1 ? BrandColors.secondary : BrandColors.primary,
                    onTap: (value) => model.changeTab(value),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Customers owing you"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("People you owe"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: <Widget>[
                        DebtorsView(),
                        CreditorsView(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}
