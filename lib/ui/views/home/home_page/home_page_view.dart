import 'package:flutter/material.dart';
import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
// import 'package:mycustomers/core/models/business_model.dart';
import 'package:stacked/stacked.dart';
// import 'package:stacked_hooks/stacked_hooks.dart';
// import 'package:flutter_screenutil/size_extension.dart';
// import '../../widgets/shared/breakdownCard.dart';
// import '../../widgets/shared/tabs.dart';
import 'home_page_viewmodel.dart';

class HomePageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Container(
            child: UnderConstruction(),
        ),
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}


/// FORMER HOME LAYOUT
/// 
// child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                         child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: _HeaderBar(),
//                     )),
//                     TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Search',
//                         prefixIcon: const Icon(Icons.search),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     BreakdownCard(
//                       payingAmount: model.amount,
//                       receivingAmount: model.amount,
//                       onClick: model.btnViewDetails,
//                       isPaying: true,
//                       isReceiving: true,
//                     ),
//                     SizedBox(height: 10),
//                     Expanded(
//                       child: DefaultTabController(
//                         length: 3,
//                         child: Column(
//                           children: <Widget>[
//                             TabBar(
//                               labelPadding:
//                                   EdgeInsets.symmetric(horizontal: 10),
//                               unselectedLabelColor: Colors.black,
//                               indicatorSize: TabBarIndicatorSize.label,
//                               indicator: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.orange,
//                               ),
//                               tabs: [
//                                 Tab(
//                                   child: Container(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("All Customers"),
//                                     ),
//                                   ),
//                                 ),
//                                 Tab(
//                                   child: Container(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("Owing Customer"),
//                                     ),
//                                   ),
//                                 ),
//                                 Tab(
//                                   child: Container(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("People You Owe"),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(top: 10),
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Text('4 Customers'),
//                                   Icon(Icons.tune)
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: TabBarView(
//                                 children: [
//                                   Tabs(),
//                                   Tabs(),
//                                   Tabs(),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 50,
//                               width: double.infinity,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: RaisedButton.icon(
//                                 onPressed: () {
//                                   model.navigateToAddCustomer();
//                                 },
//                                 color: Theme.of(context).primaryColor,
//                                 icon: Icon(
//                                   Icons.playlist_add,
//                                   color: Colors.white,
//                                 ),
//                                 label: Text(
//                                   "Add New Customer",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),


///FORMER HOME LAYOUT WIDGETS
///
///
// class _HeaderBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       // crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Expanded(flex: 4, child: BusinessSelector()),
//         SizedBox(width: 210.w),
//         Expanded(
//             flex: 2,
//             child: Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 Icon(Icons.alarm),
//                 CircleAvatar(
//                   backgroundColor: Colors.red.shade800,
//                   radius: 5.0,
//                 ),
                    
//               ],
//               overflow: Overflow.clip,
//             )),
//       ],
//     );
//   }
// }

// class BusinessSelector extends HookViewModelWidget<HomeViewModel> {
//   BusinessSelector({Key key}) : super(key: key, reactive: false);

//   @override
//   Widget buildViewModelWidget(BuildContext context, HomeViewModel model) =>
//       Container(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<Business>(
//             isExpanded: true,
//             value: model.selectedBusiness,
//             items: Business.business.map((business) {
//               return DropdownMenuItem<Business>(
//                 value: business,
//                 child: Text(
//                   business.businessName,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w900,
//                     //     color: Colors.blueAccent,
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: (value) {
//               model.changeBusiness(value);
//             },
//           ),
//         ),
//       );
// }
