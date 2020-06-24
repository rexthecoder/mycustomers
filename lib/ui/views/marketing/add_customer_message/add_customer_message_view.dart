import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';

import 'add_customer_message_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomerMessageViewModel>.reactive(
      builder: (context, model, child) => NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          // TODO: Implement Sliver AppBar
          SliverAppBar(
            title: _SearchBar(model: model),
            actions: <Widget>[
              FlatButton(
                onPressed: model.popView,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColors.error,
                  ),
                ),
                padding: EdgeInsets.all(2),
              ),
            ],
            // TODO: Implement flexible space
            flexibleSpace: PreferredSize(
              child: Row(),
              preferredSize: Size.fromHeight(60),
            ),
            // TODO: Implement customer selected count banner
            bottom: PreferredSize(
              child: Container(
                width: double.infinity,
              ),
              preferredSize: Size.fromHeight(30),
            ),
          ),
        ],
        body: ListView.builder(
          padding: EdgeInsets.all(30),
          itemBuilder: (BuildContext context, int index) {
            Customer customer = model.allCustomers[index];
            bool _isSelected = model.isSelected(customer);
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${customer.name.substring(0, 1)}'.toUpperCase(),
                  style: TextStyle(
                    color: ThemeColors.secondary,
                    fontSize: 24,
                  ),
                ),
                radius: 30,
                backgroundColor: ThemeColors.secondary.withOpacity(0.3),
              ),
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

              trailing: InkWell(
                onTap: () {
                  _isSelected ? model.deselectCustomer(customer) : model.addCustomer(customer);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  color: _isSelected ? ThemeColors.secondary : null,
                  child: Text(
                    _isSelected ? 'Selected' : 'Select',
                    style: TextStyle(
                      color: _isSelected ? ThemeColors.gray.shade600 : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: model.allCustomers.length,
        ),
      ),
      viewModelBuilder: () => AddCustomerMessageViewModel(),
    );
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
    return Container();
  }
}


