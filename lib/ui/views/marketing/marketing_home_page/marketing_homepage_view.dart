import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'marketing_homepage_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: true);
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      builder: (context, model, child) =>
          // Scaffold(
          // // backgroundColor:BrandColors.primary,
          // body:
          Container(
        child: Column(children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            width: width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Marketing',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cursorColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Show your customer that you really care about them',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).cursorColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ]),
            ),
          ),
          model.allCustomers.length == 0
              ? Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    width: width,
                    // height: height,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(children: <Widget>[
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: width / 4,
                                height: height / 4,
                                child: Image.asset(
                                  'assets/images/megaphone.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'It\'s all about sending messages to customers. Click the nice blue button below to get that started',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Theme.of(context).cursorColor),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: Theme.of(context).backgroundColor,
                                height: 50.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: () =>
                                            model.navigateToAddCustomer(),
                                        child: Container(
                                          decoration: BoxDecoration(
//                                        color: ThemeColors.gray,
                                              color: BrandColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Center(
                                            child: Text(
                                              'Add a customer',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ThemeColors.gray,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Center(
                                            child: Text(
                                              'Send message',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
              )
              : Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    width: width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Customer List',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Text(
                                          'Send message to all',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: BrandColors.secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child: Container(
                                      child: TextField(
                                        controller: model.searchController,
                                        onChanged: model.search,
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          hintText: 'Type customer name',
                                          border: InputBorder.none,
                                          focusColor: BrandColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Text('All'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            model.searchController.text != null
                                                ? model.searchedCustomer.length
                                                : model.allCustomers.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Customer customer = model
                                                      .searchController.text !=
                                                  null
                                              ? model.searchedCustomer[index]
                                              : model.allCustomers[index];
                                          bool _isSelected =
                                              model.isSelected(customer);
                                          return MyListTile(
                                            leading: CustomerCircleAvatar(
                                                customer: customer),
                                            title: Text(
                                              '${customer.name} '
                                              '${customer.lastName}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${customer.phone}',
                                              style: TextStyle(
                                                color:
                                                    ThemeColors.gray.shade600,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            trailing: Checkbox(
                                                activeColor:
                                                    BrandColors.primary,
                                                value: _isSelected,
                                                onChanged: (value) {
                                                  _isSelected
                                                      ? model.deselectCustomer(
                                                          customer)
                                                      : model.addCustomer(
                                                          customer);
                                                }),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Container(
                              color: Theme.of(context).backgroundColor,
                              height: 50.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                          model.navigateToAddCustomer(),
                                      // =>Navigator.pushNamed(context, '/addCustomerMarketing'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: BrandColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            'Add a customer',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.pushNamed(context, '/sendMessage');
//                                        model.selectedCustomers
//                                            .length ==
//                                            0
//                                            ??
                                        model.sendMessage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: model.selectedCustomers
                                                        .length ==
                                                    0
                                                ? ThemeColors.gray
                                                : BrandColors.secondary,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            'Send message',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
        ]),
      ),
      // ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }
}
