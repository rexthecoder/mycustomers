import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked_services/stacked_services.dart';

import './customerCard.dart';

class Tabs extends StatelessWidget {
  //dummy data
  final _customers = [
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
  ];

  final NavigationService _navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this._customers.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){ _navigationService.navigateTo(Routes.detailsViewRoute); },
                  child: CustomerCard(
              this._customers[index]['firstName'],
              this._customers[index]['lastName'],
              this._customers[index]['amount']),
        );
      },
    );
  }
}
