import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/models/customer.dart';

import 'import_customer_viewmodel.dart';

class ImportCustomerView extends StatelessWidget {
  final String action;

  const ImportCustomerView({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImportCustomerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
      SliverAppBar(
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        pinned: true,
        titleSpacing: 15.w,
        title: _SearchBar(model: model),
        backgroundColor: ThemeColors.background,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            onPressed: model.popView,
            child: Text(
              'Cancel',
              style: TextStyle(
                color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                fontSize: SizeConfig.yMargin(context, 2.5)
              ),
            ),
            padding: EdgeInsets.all(2),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.blurBackground,
          ],
          titlePadding: EdgeInsets.zero,
          background: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: MyListTile(
                  onTap: () => model.goToManual(action),
                  leading: CustomerCircleAvatar(
                    child: Icon(
                      Icons.person_add,
                      color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                      size: SizeConfig.xMargin(context, 7),
                    ),
                    bgColor: ThemeColors.gray.shade500,
                  ),
                  title: InkWell(
                    onTap: () => model.goToManual(action),
                    child: Text(
                      'Add New Customer',
                      style: TextStyle(
                        color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                        fontSize: SizeConfig.yMargin(context, 2.5)
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => model.goToManual(action),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.sp,
                      color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
              ),
            ),
          ),
//                  preferredSize: Size.fromHeight(110),
        ),
        bottom: PreferredSize(
            child: Container(), preferredSize: Size.fromHeight(10)),
        expandedHeight: 150,
      ),
      SliverPersistentHeader(
        delegate: TitleHeader(40, action),
        pinned: true,
      ),
      model.isLoadBusy /* || !model.dataReady*/
          ? SliverToBoxAdapter(
              child: Center(
                child: LoadingAnimation(),
              ),
            )
          : SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Customer customer = model.data[index];
                    return MyListTile(
                      leading: Center(child: CustomerCircleAvatar(customer: customer, action: action,)),
                      title: Text(
                        '${customer.displayName}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.yMargin(context, 2)
                        ),
                      ),
                      subtitle: Text(
                        '${customer.phone.isNotEmpty ? customer.phone : 'No number'}',
                        style: TextStyle(
                          color: ThemeColors.gray.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.yMargin(context, 2)
                        ),
                      ),
                      trailing: SizedBox(
                        width: SizeConfig.xMargin(context, 18),
                        height: SizeConfig.xMargin(context, 9),
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: SizeConfig.yMargin(context, 1.6),
                          ),
                          onPressed: () {
                            model.addContact(customer.displayName, customer.phone.isNotEmpty ? customer.phone : 'No number', customer.initials);
                          },
                          label: Text(
                            'ADD',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.yMargin(context, 1.6),
                            ),
                          ),
                          textColor: Colors.white,
                          color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
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
      viewModelBuilder: () => ImportCustomerViewModel(),
      onModelReady: (model) {
        model.init();
      },
    );
  }
}

class TitleHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final String action;

  TitleHeader(this.height, this.action);

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
        action == 'debtors' ? 'Add Debtor from Contacts' : 'Add Creditor from Contacts',
        style: TextStyle(
          color: ThemeColors.black,
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.yMargin(context, 2.3)
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
  final ImportCustomerViewModel model;

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
