import 'package:flutter/material.dart';

import './customerCard.dart';

class Tabs extends StatelessWidget {
  //dummy data
  final _customers = [
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
    {'firstName': 'Tunde', 'lastName': 'Edith', 'amount': 100.86},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this._customers.length,
      itemBuilder: (context, index) {
        return CustomerCard(
            this._customers[index]['firstName'],
            this._customers[index]['lastName'],
            this._customers[index]['amount']);
      },
    );
  }
}
