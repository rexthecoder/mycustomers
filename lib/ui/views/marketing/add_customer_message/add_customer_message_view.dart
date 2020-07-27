import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'add_customer_message_viewmodel.dart';

import 'package:flutter/services.dart';

class AddCustomerMessageView extends StatelessWidget {
  final String action;
  final List<Customer> frequent;

  const AddCustomerMessageView({Key key, this.action, this.frequent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).backgroundColor
        : ThemeColors.gray.shade600;

    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(
      builder: (context, model, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: BrandColors.secondary,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            appBar: customizeAppBar(
              context,
              0.0,
              title: AppLocalizations.of(context).sendMessage,
              arrowColor: BrandColors.secondary,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeColors.gray.shade700,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: model.searchController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).typeCustomerName,
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      onChanged: model.search,
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, '/addNewCustomerMarketing'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 10.w),
//

                      child: Row(
                        children: <Widget>[
                          CustomerCircleAvatar(
                            child: Icon(
                              Icons.person_add,
                              color: ThemeColors.cta,
                            ),
                            bgColor: ThemeColors.gray.shade500,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.w
//                                  : 10.w
                                  ),
                              child: Text(
                                'Add customer Manually',
//                              AppLocalizations.of(context).add,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: BrandColors.secondary,
                                  fontSize: 16.sp,
//                                        color: model.allSelected
//                                            ? ThemeColors.gray.shade800
//                                            : ThemeColors.cta,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      model.allFrequentCustomers.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(),
                            )
                          : SliverToBoxAdapter(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 40,
                                color: backgroundColor,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .frequentCustomers,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                      model.allFrequentCustomers.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(),
                            )
                          : SliverToBoxAdapter(
                              child: SizedBox(height: 10.h),
                            ),
                      model.allFrequentCustomers.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(),
                            )
                          : SliverPadding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.w, horizontal: 10),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    Customer customer =
                                        model.allFrequentCustomers[index];
                                    bool _isSelected =
                                        model.isSelected(customer);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 10.w),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
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
                                                              .gray.shade800,
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
                                                        : model.selectCustomer(
                                                            customer);
                                                  })
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: 4,
                                ),
                              ),
                            ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          height: 40,
                          color: backgroundColor,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context).phoneContacts,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      model.isLoadBusy || !model.dataReady
                          ? SliverToBoxAdapter(
                              child: Center(
                                child: LoadingAnimation(),
                              ),
                            )
                          : SliverPadding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.w, horizontal: 10),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    Customer customer = model.data[index];
                                    bool _isSelected =
                                        model.isSelected(customer);
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CustomerCircleAvatar(
                                                customer: customer,
                                                action: 'debtor',
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
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
                                                              .gray.shade800,
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
                                                        : model.selectCustomer(
                                                            customer);
                                                  })
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: model.data.length,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30.w),
                  child: FlatButton(
                    onPressed: () {
                      model.selectedCustomers.length != 0
                          ? model.returnHome()
                          : flusher(
                              AppLocalizations.of(context)
                                  .selectACustomerFromTheList,
                              context);
                    },
                    color: BrandColors.secondary,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).add,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AddCustomerMessageViewModel(),
      onModelReady: (model) {
        Future.microtask(model.init);
      },
    );
  }
}

class NewContactsHeader extends SliverPersistentHeaderDelegate {
  final double height;

  NewContactsHeader(this.height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/addNewCustomerMarketing'),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),

          child: Row(
            children: <Widget>[
              CustomerCircleAvatar(
                child: Icon(
                  Icons.person_add,
                  color: ThemeColors.cta,
                ),
                bgColor: ThemeColors.gray.shade500,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w
                      ),
                  child: Text(
                    AppLocalizations.of(context).addNewCustomer,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => this.height;

  @override
  double get minExtent => this.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
