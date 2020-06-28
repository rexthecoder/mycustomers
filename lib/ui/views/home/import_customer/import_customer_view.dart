import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'import_customer_viewmodel.dart';

class ImportCustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImportCustomerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
                      color: ThemeColors.link,
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
                        leading: CustomerCircleAvatar(
                          child: Icon(
                            Icons.person_add,
                            color: ThemeColors.cta,
                          ),
                          bgColor: ThemeColors.gray.shade500,
                        ),
                        title: InkWell(
                          onTap: () {
                            // TODO: Implement add customer manually screen function
                          },
                          child: Text(
                            'Add New Customer',
                            style: TextStyle(
                              color: ThemeColors.cta,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            // TODO: Implement add customer manually screen function
                          },
                          icon: Icon(Icons.add, color: ThemeColors.cta,),
                          padding: EdgeInsets.symmetric(horizontal: 0),
                        ),
                      ),
                    ),
                  ),
                ),
//                  preferredSize: Size.fromHeight(110),
              ),
              bottom: PreferredSize(child: Container(), preferredSize: Size.fromHeight(10)),
              expandedHeight: 150,
            ),
            SliverPersistentHeader(delegate: TitleHeader(40), pinned: true,),
            model.isBusy
                ? SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Customer customer = model.allCustomers[index];
                    bool _isSelected = model.isSelected(customer);
                    return MyListTile(
                      leading: CustomerCircleAvatar(customer: customer),
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
                          color: ThemeColors.gray.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: FlatButton.icon(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          // TODO: Change function to route to Transaction screen
                          _isSelected
                              ? model.deselectCustomer(customer)
                              : model.addCustomer(customer);
                        },
                        label: Text(
                          'ADD',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: Colors.white,
                        color: BrandColors.secondary,
                        padding: EdgeInsets.zero,
                      ),
                    );
                  },
                  childCount: model.allCustomers.length,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ImportCustomerViewModel(),
    );
  }
}

class TitleHeader extends SliverPersistentHeaderDelegate {

  final double height;

  TitleHeader(this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ThemeColors.gray.shade400,
        boxShadow: !overlapsContent ? null : [BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 8,
          color: ThemeColors.gray.shade600,
        )],
      ),
      child: Text(
        // This is just the text formatting for singular and plural
        'Add Debtor from Contacts',
        style: TextStyle(
          color: ThemeColors.black,
          fontWeight: FontWeight.bold,
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