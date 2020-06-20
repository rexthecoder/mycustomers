import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';

import '../../widgets/shared/breakdownCard.dart';
import '../../widgets/shared/tabs.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final NavigationService _navigatorService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: SafeArea(
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                      SizedBox(height: 10),
                      BreakdownCard(
                        payingAmount: model.amount,
                        receivingAmount: model.amount,
                        onClick: model.btnViewDetails,
                        isPaying: true,
                        isReceiving: true,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                unselectedLabelColor: Colors.black,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange,
                                ),
                                tabs: [
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("All Customers"),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Owing Customer"),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("People You Owe"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('4 Customers'),
                                    Icon(Icons.tune)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TabBarView(
                                  children: [
                                    Tabs(),
                                    Tabs(),
                                    Tabs(),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RaisedButton.icon(
                                  onPressed: () {
                                    _navigatorService.navigateTo(Routes.addcustomerRoute);
                                  },
                                  color: Theme.of(context).primaryColor,
                                  icon: Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Add New Customer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
