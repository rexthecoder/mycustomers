// import 'package:flutter/material.dart';
// import 'package:mycustomers/ui/shared/const_color.dart';
// import 'package:mycustomers/ui/views/add_customer_manually/partial_build_view.dart';
// import 'package:stacked/stacked.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'add_customer_manually_viewmodel.dart';

// class AddCustomerManuallyView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
  
//   return ViewModelBuilder<AddCustomerManuallyViewModel>.reactive(
//       builder: (context, model, child) => Scaffold(
//         backgroundColor: ThemeColors.background,
//         appBar: AppBar(
//           backgroundColor: ThemeColors.background,
//           centerTitle: true,
//           elevation: 1,
//           title: Text(
//             model.title,
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: ThemeColors.black,
//             ),
//           ),
//           iconTheme: IconThemeData(color: ThemeColors.black),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   model.subTitle,
//                   style: TextStyle(fontSize: 18.sp, color: ThemeColors.black),
//                 ),
//                 SizedBox(height: 16.0),
//                 PartialBuildsView(),
//                 Spacer(),
//                 Container(
//                   width: double.infinity,
//                   child: FlatButton(
//                     color: BrandColors.secondary,
//                     onPressed: () {},
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 16.h),
//                     child: Text(
//                       'Next',
//                       style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       viewModelBuilder: () => AddCustomerManuallyViewModel(),
//     );
//   }
// }
