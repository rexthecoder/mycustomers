import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart' as appbar;
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_customer_message_viewmodel.dart';

class AddCustomerMessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color backgroundColor = Theme.of(context).brightness==Brightness.dark?Theme.of(context).backgroundColor :ThemeColors.gray.shade400;


    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: customizeAppBar(context, 1.0,
            title: 'Select contacts', arrowColor: BrandColors.secondary),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.gray.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: TextField(
                          controller: model.searchController,
                          decoration: InputDecoration(
                            hintText: 'Type customer name',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30.w
//                                  : 10.w
                                            ),
                                    child: Text(
                                       AppLocalizations.of(context).addNewCustomer,
                                      style: TextStyle(
                                        color: model.allSelected
                                            ? ThemeColors.gray.shade800
                                            : ThemeColors.cta,
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
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              model.allFrequentCustomers.length == 0
                                  ? Container()
                                  :Container(
                                width: double.infinity,
                                height: 40,
                                color: backgroundColor,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'FREQUENT CUSTOMERS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              model.allFrequentCustomers.length == 0
                                  ? Container()
                                  :SizedBox(height: 10.h),
                              model.allFrequentCustomers.length == 0
                                  ? Container()
                                  :ListView.builder(
                                      itemCount: 4,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Customer customer =
                                            model.allCustomers[index];
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
                                        );
                                      }),
                              Container(
                                width: double.infinity,
                                height: 40,
                                color: backgroundColor,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'PHONE CONTACTS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              model.allCustomers.length == 0
                                  ? Center(
                                      child: LoadingAnimation(),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          model.searchController.text != null
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
//                                    return MyListTile(
//                                      leading:
//                                      CustomerCircleAvatar(customer: customer),
//                                      title: Text(
//                                        '${customer.name} '
//                                            '${customer.lastName}',
//                                        style: TextStyle(
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      ),
//                                      subtitle: Text(
//                                        '${customer.phone}',
//                                        style: TextStyle(
//                                          color: ThemeColors.gray.shade600,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      ),
//                                      trailing:  Checkbox(
//                                          activeColor:
//                                          BrandColors.primary,
//                                          value: _isSelected,
//                                          onChanged: (value) {
//                                            _isSelected
//                                                ? model.deselectCustomer(
//                                                customer)
//                                                : model.addCustomer(
//                                                customer);
//                                          }),
//                                    );
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
                                        );
                                      }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30.w),
                  child: FlatButton(
                    onPressed: () {
                      model.returnCustomers();
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
                           AppLocalizations.of(context).continueButton,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AddCustomerMessageViewModel(),
    );
  }
}

class CustomerCount extends SliverPersistentHeaderDelegate {
  final double height;
  final AddCustomerMessageViewModel model;

  CustomerCount(this.height, this.model);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ThemeColors.gray.shade400,
        boxShadow: !overlapsContent
            ? null
            : [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 8,
                  color: ThemeColors.gray.shade600,
                )
              ],
      ),
      child: Text(
        // This is just the text formatting for singular and plural
        '${!model.hasSelected ? 'No' : model.numberOfSelected} ' // 0 or more
        'Customer${model.numberOfSelected == 1 ? '' : 's'} ' // 1 or another number
        'Selected',
        style: TextStyle(
          color:
              model.hasSelected ? ThemeColors.link : ThemeColors.gray.shade800,
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

class _SearchBar extends StatefulWidget {
  final AddCustomerMessageViewModel model;

  const _SearchBar({Key key, this.model}) : super(key: key);

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: Remove Container and use appropriate properties
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.gray.shade700,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5.w),
//        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        controller: widget.model.searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          fillColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        onChanged: widget.model.search,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
