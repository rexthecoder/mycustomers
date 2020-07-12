import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/views/home/home_page/tabs/debtors_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'home_page_viewmodel.dart';
import 'tabs/creditors_view.dart';

class HomePageView extends StatelessWidget {
  //TODO: Position notification bell dot properly

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model){
        model.getContacts();
        model.getTransactions();
      },
      builder: (context, model, child) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey, width: 0.5))),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    unselectedLabelColor: Colors.black,
                    labelColor: BrandColors.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: BrandColors.primary,
                    tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Customers owing you",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Customers you owe",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "All Customers",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: <Widget>[
                        DebtorsView(),
                        CreditorsView(),
                        ContactList()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                child: TextField(
                  //controller: model.allCustomersController,
                  //onChanged: model.searchAllCustomers,
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 14,),
                  decoration: InputDecoration(
                    hintText: 'Search by name',
                    hintStyle: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 14,

                    ),
                    contentPadding:  const EdgeInsets.only(top: 18.0),
                    prefixIcon:   Icon(Icons.search,color: BrandColors.primary,),
                    border: InputBorder.none,
                  ),
                  onChanged: model.searchName,
                ),
              ),
              for (var item in model.contacts) model.contacts.length == 0 ? Expanded(
                child: Center(
                  child: Text(
                    'No Customer Added'
                  ),
                ),
              ) : model.sName != null && model.contains ?
              item.name.contains(model.sName) || item.name.contains(model.sName.toUpperCase()) || item.name.contains(model.sName[0].toUpperCase()+model.sName.substring(1)) || item.name.contains(model.sName.toLowerCase()) ?
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFD1D1D1)),
                      //bottom: BorderSide(color: Color(0xFFD1D1D1))
                    )
                  ),
                  child: ListTile(
                    onTap: () => model.setContact(item.id, item.name, item.phoneNumber),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/man.png',
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    title: Text(
                      item.name
                    ),
                  ),
                ),
              )
              : SizedBox()
              : model.sName != null && !model.contains ? SizedBox() : Container(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFD1D1D1)),
                      //bottom: BorderSide(color: Color(0xFFD1D1D1))
                    )
                  ),
                  child: ListTile(
                    onTap: () => model.setContact(item.id, item.name, item.phoneNumber),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/man.png',
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    title: Text(
                      item.name
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}