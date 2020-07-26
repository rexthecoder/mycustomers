import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'marketing_homepage_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: true);
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      onModelReady: (model) => model.getContacts(),
      builder: (context, model, child) => Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: <Widget>[
          Container(
            width: SizeConfig.xMargin(context, 110),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.xMargin(context, 3),
                vertical: SizeConfig.xMargin(context, 3)),
            decoration: BoxDecoration(
              color: BrandColors.primary,
            ),
            child: Text(AppLocalizations.of(context).marketing,
                style: TextStyle(
                    fontSize: SizeConfig.textSize(context, 8),
                    color: Theme.of(context).backgroundColor)),
          ),
          Card(
            margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 2)),
            elevation: 4,
            color: Theme.of(context).backgroundColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: FlatButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () async {
                    final bool isPermitted = await model.checkPermission();
                    if (isPermitted) {
                      model.navigateToAddCustomers(context);
                      return;
                    } else {
                      permissionDialog(context, model);
                    }
                    model.navigateToAddCustomer();
                  },
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person_add,
                            color: BrandColors.primary,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(AppLocalizations.of(context).addNewCustomer,
                              style: TextStyle(color: BrandColors.primary)),
                        ]),
                  ),
                )),
                Expanded(
                    child: FlatButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    model.selectedCustomers.length != 0
                        ? model.navigateToSendMessageView()
                        : flusher(
                            AppLocalizations.of(context)
                                .selectACustomerFromTheList,
                            context);
                  },
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: BrandColors.primary,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(AppLocalizations.of(context).sendMessage,
                              style: TextStyle(color: BrandColors.primary)),
                        ]),
                  ),
                )),
              ],
            ),
          ),
          model.customers.length == 0
              ? Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/icons/svg/marketing_home.svg',
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 3),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .itsAllAboutSendingMessagesToCustomers,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).textSelectionColor),
                                textAlign: TextAlign.center,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
                                  color:
                                      BrandColors.secondary.withOpacity(0.07),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .sendMessageAll,
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
                          height: 5.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: model.searchController,
                            onChanged: model.search,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,
                                  size: SizeConfig.xMargin(context, 4)),
                              hintText:
                                  AppLocalizations.of(context).typeCustomerName,
                              border: InputBorder.none,
                              focusColor: BrandColors.primary,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[500],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        model.frequents.length == 0 ||
                                model.searchTerm.length > 0
                            ? Container()
                            : Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .frequentlyContacted,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: BrandColors.primary,
                                      fontSize:
                                          SizeConfig.textSize(context, 4)),
                                ),
                              ),
                        SizedBox(
                          height: 5.h,
                        ),
                        model.frequents.length == 0 ||
                                model.searchTerm.length > 0
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(0.0),
                                    itemCount: model.frequents.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      CustomerContact customer =
                                          model.frequents[index];
                                      bool _isSelected = model.selectedCustomers
                                          .contains(customer);
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15.h,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                CustomerCircleAvatar(
                                                  ccustomer: customer,
                                                  action: 'debtor',
                                                  bgColor: Color.fromRGBO(
                                                      51, 60, 193, 0.2),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () => model
                                                        .navigateToMessageHistory(
                                                            customer),
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            '${customer.name}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.sp,
                                                          ),
                                                          Text(
                                                            model.getmsg(customer
                                                                        .id) !=
                                                                    null
                                                                ? model
                                                                    .getmsg(
                                                                        customer
                                                                            .id)
                                                                    .message
                                                                : '',
                                                            style: TextStyle(
                                                              color: ThemeColors
                                                                  .gray
                                                                  .shade800,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Checkbox(
                                                    checkColor:
                                                        BrandColors.primary,
                                                    activeColor:
                                                        Color(0xffE1E1E1),
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
                                            color: Colors.grey[500],
                                          )
                                        ],
                                      );
                                    }),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        model.customers.length == 0
                            ? Container()
                            : Container(
                                width: double.infinity,
                                height: 15.h,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalizations.of(context).all,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: BrandColors.primary),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 5.h,
                        ),
                        model.customers.length == 0
                            ? Center(
                                child: LoadingAnimation(),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(0.0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: (model?.searchController?.text
                                                ?.isNotEmpty ??
                                            false)
                                        ? model.scustomers.length
                                        : model.customers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      CustomerContact customer = (model
                                                  ?.searchController
                                                  ?.text
                                                  ?.isNotEmpty ??
                                              false)
                                          ? model.scustomers[index]
                                          : model.customers[index];
                                      bool _isSelected = model.selectedCustomers
                                          .contains(customer);
                                      return Dismissible(
                                        background: Container(
                                          padding: EdgeInsets.only(right: 15),
                                          color: Colors.red,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.delete,
                                                color: Colors.white),
                                          ),
                                        ),
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        onDismissed:
                                            (DismissDirection direction) {
                                          model.deleteCustomer(customer);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15.h,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  CustomerCircleAvatar(
                                                    ccustomer: customer,
                                                    action: 'debtor',
                                                    bgColor: Color.fromRGBO(
                                                        51, 60, 193, 0.2),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () => model
                                                          .navigateToMessageHistory(
                                                              customer),
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              '${customer.name}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.sp,
                                                            ),
                                                            Text(
                                                              model.getmsg(customer
                                                                          .id) !=
                                                                      null
                                                                  ? model
                                                                          .getmsg(
                                                                              customer.id)
                                                                          .message ??
                                                                      ''
                                                                  : '',
                                                              style: TextStyle(
                                                                color: ThemeColors
                                                                    .gray
                                                                    .shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      checkColor:
                                                          BrandColors.primary,
                                                      activeColor:
                                                          Color(0xffE1E1E1),
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
                                              color: Colors.grey[500],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
        ]),
      ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }

  Future<void> permissionDialog(
      BuildContext context, MarketingHomePageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF333CC1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      AppLocalizations.of(context).accessDenied,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    child: Text(
                      AppLocalizations.of(context)
                          .myCustomerNeedsAccessToYourContacts,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              model.navigateToAddNewCustomer(context);
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).deny,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              model.requestPermission();
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).allow,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      }
}
