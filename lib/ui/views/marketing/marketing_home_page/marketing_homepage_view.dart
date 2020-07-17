import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';

import 'marketing_homepage_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Color backgroundColor = Theme.of(context).brightness==Brightness.dark?Theme.of(context).backgroundColor :ThemeColors.gray[400];
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
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).marketing,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cursorColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                       AppLocalizations.of(context).marketingSpeech,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).cursorColor),
                    ),
                  ]),
            ),
          ),
          model.allCustomers.length != 0
              ? Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                )
              : Container(),
          model.allCustomers.length == 0
              ? Expanded(
                  child: Container(
                    color: backgroundColor,
                   width: width,
                    // height: height,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
//                              SizedBox(
////                                    height: 10,
//                                height: SizeConfig.yMargin(context, 5),
//                              ),
                              ClipRect(
                                child: Image(
                                  height: height / 4,
                                  image:
                                      AssetImage('assets/images/megaphone.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 3),
                              ),
                              Text(
                                 AppLocalizations.of(context).marketingDesc,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Theme.of(context).cursorColor),
                                textAlign: TextAlign.center,
// =======
//                               Container(
//                                 color: ThemeColors.gray[400],
//                                 height: 50.h,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: InkWell(
//                                         child: Container(
//                                           decoration: BoxDecoration(
// //                                        color: ThemeColors.gray,
//                                               color: ThemeColors.gray[400],
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           child: Center(
//                                             child: Text(
//                                               AppLocalizations.of(context)
//                                                   .addACustomer,
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: ThemeColors.gray[400]),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10.w,
//                                     ),
//                                     Expanded(
//                                       child: InkWell(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color: BrandColors.secondary,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           child: Center(
//                                             child: Text(
//                                               AppLocalizations.of(context)
//                                                   .sendMessage,
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
// >>>>>>> language
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                   AppLocalizations.of(context).customerList,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  child: Container(
                                    color: BrandColors.secondary.withOpacity(0.07),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                         AppLocalizations.of(context).sendMessageAll,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: BrandColors.secondary),

                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Container(
                              child: TextField(
                                controller: model.searchController,
                                onChanged: model.search,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText:  AppLocalizations.of(context).typeCustomerName,
                                  border: InputBorder.none,
                                  focusColor: BrandColors.primary,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          model.allFrequentCustomers.length == 0
                              ? Container()
                              :Container(
                            width: double.infinity,
                            height: 15.h,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                 AppLocalizations.of(context).frequentlyContacted,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: BrandColors.primary),
                              ),
                            ),
                          ),
                          model.allFrequentCustomers.length == 0
                              ? Container()
                              : ListView.builder(
                                  itemCount: model.allFrequentCustomers.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Customer customer =
                                    model.allFrequentCustomers[index];
                                    bool _isSelected =
                                        model.isSelected(customer);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      child: Row(
                                        children: <Widget>[
                                          CustomerCircleAvatar(
                                            customer: customer,
                                            action: 'debtor',
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 30.w),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${customer.name} '
                                                    '${customer.lastName}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.sp,
                                                  ),
                                                  Text(
                                                    '${customer.phone}',
                                                    style: TextStyle(
                                                      color: ThemeColors
                                                          .gray.shade600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Checkbox(
                                              activeColor: BrandColors.primary,
                                              value: _isSelected,
                                              onChanged: (value) {
                                                _isSelected
                                                    ? model.deselectCustomer(
                                                        customer)
                                                    : model
                                                        .addCustomer(customer);
                                              })
                                        ],
                                      ),
                                    );
                                  }),
                          model.allFrequentCustomers.length == 0
                              ? Container()
                              : Divider(
                            color: Colors.grey[300],
                          ),
                          model.allFrequentCustomers.length == 0
                              ? Container()
                              :SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 15.h,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                 AppLocalizations.of(context).all,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: BrandColors.primary),
                              ),
                            ),
                          ),
                          model.allCustomers.length == 0
                              ? Center(
                                  child: LoadingAnimation(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.searchController.text != null
                                      ? model.searchedCustomer.length
                                      : model.allCustomers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Customer customer =
                                        model.searchController.text != null
                                            ? model.searchedCustomer[index]
                                            : model.allCustomers[index];
                                    bool _isSelected =
                                        model.isSelected(customer);
                                    return Dismissible(
                                      background: Container(
                                        color: BrandColors.secondary,
                                      ),
                                      key: Key(index.toString()),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        model.removeCustomers(index);
                                      },
                                      // onDismissed: (direction) =>
                                      //     model.removeCustomers(index),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                                horizontal: 10.w),
                                            child: Row(
                                              children: <Widget>[
                                                CustomerCircleAvatar(
                                                  customer: customer,
                                                  action: 'debtor',
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.w),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          '${customer.name} '
                                                          '${customer.lastName}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 3.sp,
                                                        ),
                                                        Text(
                                                          '${customer.phone}',
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .gray.shade600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Checkbox(
                                                    activeColor:
                                                        BrandColors.primary,
                                                    value: _isSelected,
                                                    onChanged: (value) {
                                                      _isSelected
                                                          ? model
                                                              .deselectCustomer(
                                                                  customer)
                                                          : model.addCustomer(
                                                              customer);
                                                    })
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    ),
                  ),
                ),
//                         Expanded(
//                  child: Container(
//                    color: ThemeColors.gray[400],
//                    width: width,
//                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 5.h,
//                                  ),
//                                  Container(
//                                    padding: const EdgeInsets.symmetric(
//                                      horizontal: 20.0,
//                                    ),
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text(
//                                          'Customer List',
//                                          style: TextStyle(
//                                            fontSize: 20.sp,
//                                          ),
//                                        ),
//                                        Text(
//                                          'Send message to all',
//                                          style: TextStyle(
//                                              fontSize: 14.sp,
//                                              color: BrandColors.secondary),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10.h,
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 15.0, vertical: 10),
//                                    child: Container(
//                                      child: TextField(
//                                        controller: model.searchController,
//                                        onChanged: model.search,
//                                        textInputAction: TextInputAction.search,
//                                        decoration: InputDecoration(
//                                          prefixIcon: Icon(Icons.search),
//                                          hintText: 'Type customer name',
//                                          border: InputBorder.none,
//                                          focusColor: BrandColors.primary,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0, vertical: 10),
//                                    child: Text('All'),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0),
//                                    child: ListView.builder(
//                                        shrinkWrap: true,
//                                        physics: NeverScrollableScrollPhysics(),
//                                        itemCount:
//                                            model.searchController.text != null
//                                                ? model.searchedCustomer.length
//                                                : model.allCustomers.length,
//                                        itemBuilder:
//                                            (BuildContext context, int index) {
//                                          Customer customer = model
//                                                      .searchController.text !=
//                                                  null
//                                              ? model.searchedCustomer[index]
//                                              : model.allCustomers[index];
//                                          bool _isSelected =
//                                              model.isSelected(customer);
//                                          return Dismissible(
//                                            background: Container(color: Colors.red,),
//                                            key: Key(index.toString()),
//                                            onDismissed: (direction)=>model.removeCustomers(index),
//                                            child: MyListTile(
//                                              leading: CustomerCircleAvatar(
//                                                  customer: customer),
//                                              title: Text(
//                                                customer.lastName!=null?
//                                                '${customer.name} '
//                                                '${customer.lastName}':'${customer.name} ',
//                                                style: TextStyle(
//                                                  fontWeight: FontWeight.w600,
//                                                ),
//                                              ),
//                                              subtitle: Text(
//                                                '${customer.phone}',
//                                                style: TextStyle(
//                                                  color:
//                                                      ThemeColors.gray.shade600,
//                                                  fontWeight: FontWeight.w600,
//                                                ),
//                                              ),
//                                              trailing: Checkbox(
//                                                  activeColor:
//                                                      BrandColors.primary,
//                                                  value: _isSelected,
//                                                  onChanged: (value) {
//                                                    _isSelected
//                                                        ? model.deselectCustomer(
//                                                            customer)
//                                                        : model.addCustomer(
//                                                            customer);
//                                                  }),
//                                            ),
//                                          );
//                                        }),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                        ]),
//                  ),
//                ),
          model.selectedCustomers.length != 0
              ? Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      height: 50.h,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => model.navigateToAddCustomer(),
                            color: BrandColors.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Container(
                              width: width / 2,
                              child: Center(
                                child: Text(
                                   AppLocalizations.of(context).sendMessage,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : model.allCustomers.length == 0
                  ? Container(
                      color: backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Container(
                          height: 50.h,
                          color: backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () => model.navigateToAddCustomer(),
                                color: BrandColors.secondary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Container(
                                  width: width / 2,
                                  child: Center(
                                    child: Text(
                                       AppLocalizations.of(context).sendMessage,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),

//              : Expanded(
//                  child: Container(
//                    color: ThemeColors.gray[400],
//                    width: width,
//                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 5.h,
//                                  ),
//                                  Container(
//                                    padding: const EdgeInsets.symmetric(
//                                      horizontal: 20.0,
//                                    ),
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text(
//                                          'Customer List',
//                                          style: TextStyle(
//                                            fontSize: 20.sp,
//                                          ),
//                                        ),
//                                        Text(
//                                          'Send message to all',
//                                          style: TextStyle(
//                                              fontSize: 14.sp,
//                                              color: BrandColors.secondary),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10.h,
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 15.0, vertical: 10),
//                                    child: Container(
//                                      child: TextField(
//                                        controller: model.searchController,
//                                        onChanged: model.search,
//                                        textInputAction: TextInputAction.search,
//                                        decoration: InputDecoration(
//                                          prefixIcon: Icon(Icons.search),
//                                          hintText: 'Type customer name',
//                                          border: InputBorder.none,
//                                          focusColor: BrandColors.primary,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0, vertical: 10),
//                                    child: Text('All'),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 20.0),
//                                    child: ListView.builder(
//                                        shrinkWrap: true,
//                                        physics: NeverScrollableScrollPhysics(),
//                                        itemCount:
//                                            model.searchController.text != null
//                                                ? model.searchedCustomer.length
//                                                : model.allCustomers.length,
//                                        itemBuilder:
//                                            (BuildContext context, int index) {
//                                          Customer customer = model
//                                                      .searchController.text !=
//                                                  null
//                                              ? model.searchedCustomer[index]
//                                              : model.allCustomers[index];
//                                          bool _isSelected =
//                                              model.isSelected(customer);
//                                          return MyListTile(
//                                            leading: CustomerCircleAvatar(
//                                                customer: customer),
//                                            title: Text(
//                                              '${customer.name} '
//                                              '${customer.lastName}',
//                                              style: TextStyle(
//                                                fontWeight: FontWeight.w600,
//                                              ),
//                                            ),
//                                            subtitle: Text(
//                                              '${customer.phone}',
//                                              style: TextStyle(
//                                                color:
//                                                    ThemeColors.gray.shade600,
//                                                fontWeight: FontWeight.w600,
//                                              ),
//                                            ),
//                                            trailing: Checkbox(
//                                                activeColor:
//                                                    BrandColors.primary,
//                                                value: _isSelected,
//                                                onChanged: (value) {
//                                                  _isSelected
//                                                      ? model.deselectCustomer(
//                                                          customer)
//                                                      : model.addCustomer(
//                                                          customer);
//                                                }),
//                                          );
//                                        }),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.symmetric(
//                                horizontal: 20.0, vertical: 10),
//                            child: Container(
//                              color: Theme.of(context).backgroundColor,
//                              height: 50.h,
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Expanded(
//                                    child: InkWell(
//                                      onTap: () =>
//                                          model.navigateToAddCustomer(),
//                                      // =>Navigator.pushNamed(context, '/addCustomerMarketing'),
//                                      child: Container(
//                                        decoration: BoxDecoration(
//                                            color: BrandColors.primary,
//                                            borderRadius:
//                                                BorderRadius.circular(5.0)),
//                                        child: Center(
//                                          child: Text(
//                                            'Add a customer',
//                                            style: TextStyle(
//                                                fontSize: 14.sp,
//                                                color: Colors.white),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 10.w,
//                                  ),
//                                  Expanded(
//                                    child: InkWell(
//                                      onTap: () {
//                                        // Navigator.pushNamed(context, '/sendMessage');
////                                        model.selectedCustomers
////                                            .length ==
////                                            0
////                                            ??
//                                        model.sendMessage();
//                                      },
//                                      child: Container(
//                                        decoration: BoxDecoration(
//                                            color: model.selectedCustomers
//                                                        .length ==
//                                                    0
//                                                ? ThemeColors.gray
//                                                : BrandColors.secondary,
//                                            borderRadius:
//                                                BorderRadius.circular(5.0)),
//                                        child: Center(
//                                          child: Text(
//                                            'Send message',
//                                            style: TextStyle(
//                                                fontSize: 14.sp,
//                                                color: Colors.white),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ]),
//                  ),
//                ),
        ]),
      ),
      // ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }
}