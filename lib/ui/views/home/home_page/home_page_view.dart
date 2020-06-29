import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/core/models/business_model.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/home/home_page/tabs/all_customers_view.dart';
import 'package:mycustomers/ui/views/home/home_page/tabs/debtors_view.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
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
      builder: (context, model, child) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xff333cc1),
                  height: SizeConfig.yMargin(context, 10),
                  child: Stack(
                    children: <Widget>[
                      // Container(
                      //   height: SizeConfig.yMargin(context, 10),
                      //   color: Color(0xff333cc1),
                      // ),
                      Positioned(
                        top: SizeConfig.yMargin(context, -12.0),
                        left: SizeConfig.yMargin(context, -10.0),
                        child: circleDesign(SizeConfig.yMargin(context, 10),
                            SizeConfig.yMargin(context, 7)),
                      ),
                      Positioned(
                        top: SizeConfig.yMargin(context, -12.0),
                        right: SizeConfig.yMargin(context, -12.0),
                        child: circleDesign(SizeConfig.yMargin(context, 10),
                            SizeConfig.yMargin(context, 7)),
                      ),
                      Padding(
                        padding:EdgeInsets.all(SizeConfig.yMargin(context, 3)),
                        child: _HeaderBar(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey, width: 0.8.w))),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xFF333CC1),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFF333CC1),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Debtors"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Creditors"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("All customers"),
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
                        AllCustomersView()
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

class _HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BusinessSelector(),
        Expanded(
          child: SizedBox(),
        ),
        Container(
          child: Stack(
          //  alignment: Alignment.topRight,
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              Positioned(
               right: SizeConfig.yMargin(context, 2.6),
                top: SizeConfig.yMargin(context, 2.6),
                              child: CircleAvatar(
                  backgroundColor: Color(0xFFFDA741),
                  radius: SizeConfig.xMargin(context, 0.9 ),
                ),
              ),
            ],
            overflow: Overflow.clip,
          ),
        ),
      ],
    );
  }
}

class BusinessSelector extends HookViewModelWidget<HomePageViewModel> {
  BusinessSelector({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, HomePageViewModel model) =>
      Container(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Business>(
            dropdownColor: Colors.black,
            value: model.selectedBusiness,
            items: Business.business.map((business) {
              return DropdownMenuItem<Business>(
                value: business,
                child: Text(
                  business.businessName,
                  style: TextStyle(
                    fontSize: SizeConfig.yMargin(context, 2),
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    //     color: Colors.blueAccent,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              model.changeBusiness(value);
            },
          ),
        ),
      );
}
