import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
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
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      onModelReady: (model) => model.getContacts(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColors.primary,
          centerTitle: false,
          title: Text(
            AppLocalizations.of(context).marketing,
            style: TextStyle(
              color: ThemeColors.background,
              fontSize: SizeConfig.textSize(context, 6),
              fontWeight: FontWeight.normal
             ),
          ),
          elevation: 0,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(children: <Widget>[
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

                      } else {
                        permissionDialog(context, model);
                      }
                    },
                        child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person_add,
                              size: SizeConfig.xMargin(context, 8),
                              color: Theme.of(context).textSelectionColor,
                            ),
                            SizedBox(
                              height: SizeConfig.yMargin(context, 0.8),
                            ),
                            Text(AppLocalizations.of(context).addNewCustomer,
                                style: TextStyle(
                                  fontSize: SizeConfig.textSize(context, 4),
                                    color:
                                        Theme.of(context).textSelectionColor)),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.message,
                              size: SizeConfig.xMargin(context, 8),
                              color: Theme.of(context).textSelectionColor,
                            ),
                            SizedBox(
                              height: SizeConfig.yMargin(context, 0.8),
                            ),
                            Text(AppLocalizations.of(context).sendMessage,
                                style: TextStyle(
                                    fontSize: SizeConfig.textSize(context, 4),
                                    color:
                                        Theme.of(context).textSelectionColor)),
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
                      width: double.infinity,
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
                                    height: SizeConfig.yMargin(context, 18)
                                ),
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 3),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .itsAllAboutSendingMessagesToCustomers,
                                  style: TextStyle(
                                      fontSize:  SizeConfig.textSize(context, 4),
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
                                      fontSize: SizeConfig.textSize(context, 5),
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap:()=> model.navigateToSendMessageAllView() ,
                                  child: Container(
                                    color:
                                        BrandColors.secondary.withOpacity(0.07),
                                    child: Padding(
                                      padding:  EdgeInsets.all(SizeConfig.xMargin(context, 2)),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .sendMessageAll,
                                        style: TextStyle(
                                            fontSize: SizeConfig.textSize(context, 3.8),
                                            color: BrandColors.secondary),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.yMargin(context, 1),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                            ),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: model.searchController,
                              onChanged: model.search,
                              textInputAction: TextInputAction.search,
                              style: TextStyle(
                                fontSize: SizeConfig.textSize(context, 3),
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,
                                    size: SizeConfig.xMargin(context, 6)),
                                hintText: AppLocalizations.of(context)
                                    .typeCustomerName,

                                border: InputBorder.none,
                                focusColor: BrandColors.primary,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[500],
                          ),
                          SizedBox(
                            height: SizeConfig.yMargin(context, 2),
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
                            height: SizeConfig.yMargin(context, 0.8),
                          ),
                          model.frequents.length == 0 ||
                                  model.searchTerm.length > 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(0.0),
                                      itemCount: model.frequents.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        CustomerContact customer =
                                            model.frequents[index];
                                        bool _isSelected = model
                                            .selectedCustomers
                                            .contains(customer);
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:CrossAxisAlignment.center,
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
                                                                    10),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text(
                                                              '${customer.name}',
                                                              style:
                                                              TextStyle(
                                                                fontSize: SizeConfig.textSize(context, 4),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig.yMargin(context, 0.8),
                                                            ),
                                                            model.getmsg(customer) !=
                                                                null
                                                                ?   Text(
                                                              model.getmsg(customer)
                                                                  .message ??
                                                                  '',
                                                              style:
                                                              TextStyle(
                                                                fontSize: SizeConfig.textSize(context, 3.5),
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
                                                            ):Container()

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
                            height: SizeConfig.yMargin(context, 2),
                          ),
                          model.customers.length == 0
                              ? Container()
                              : Container(
                                  width: double.infinity,
                                  height: SizeConfig.yMargin(context, 4),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      AppLocalizations.of(context).all,
                                      style: TextStyle(
                                        fontSize: SizeConfig.textSize(context, 3.5),
                                          fontWeight: FontWeight.w600,
                                          color: BrandColors.primary),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: SizeConfig.yMargin(context, 0.8),
                          ),
                          model.customers.length == 0
                              ? Center(
                                  child: LoadingAnimation(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                        bool _isSelected = model
                                            .selectedCustomers
                                            .contains(customer);
                                        return Dismissible(
                                          background: Container(
                                            padding: EdgeInsets.only(right: 15),
                                            color: Colors.red,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(Icons.delete,
                                                  size: SizeConfig.xMargin(context, 5),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          key: UniqueKey(),
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed:
                                              (DismissDirection direction) {
                                            model.deleteCustomer(customer);
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 15,
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
                                                                      10),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text(
                                                                '${customer.name}',
                                                                style:
                                                                    TextStyle(
                                                                      fontSize: SizeConfig.textSize(context, 4),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              model.getmsg(customer) !=
                                                                  null
                                                                  ?SizedBox(
                                                                  height: SizeConfig.yMargin(context, 0.8),
                                                              ):Container(),
                                                              model.getmsg(customer) !=
                                                                  null
                                                                  ?   Text(
                                                               model.getmsg(customer)
                                                                            .message ??
                                                                        '',
                                                                style:
                                                                    TextStyle(
                                                                      fontSize: SizeConfig.textSize(context, 3.5),
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
                                                              ):Container()
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
                                                              : model
                                                                  .addCustomer(
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
                        fontSize: SizeConfig.textSize(context, 4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .myCustomerNeedsAccessToYourContacts,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textSize(context, 4),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 4),
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
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).deny,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: SizeConfig.textSize(context, 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.xMargin(context, 1),
                      ),
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              model.requestPermission();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).allow,
                                  style: TextStyle(
                                    color: Color(0xFF333CC1),
                                    fontSize: SizeConfig.textSize(context, 3),
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
