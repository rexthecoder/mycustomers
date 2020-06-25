// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mycustomers/core/mixings/validators.dart';
// import 'package:mycustomers/ui/shared/const_widget.dart';
// import 'package:mycustomers/ui/shared/size_config.dart';
// import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
// import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:stacked/stacked.dart';
// import 'package:flutter_screenutil/size_extension.dart';

// import 'signup_viewmodel.dart';

// class SignUpView extends StatelessWidget with Validators {
//   TextEditingController _inputNumberController;
//   final _formPageKey = GlobalKey<FormState>();
//   final _pageKey = GlobalKey<ScaffoldState>();

//   final _k1 = new GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     ScreenUtil.init(context, width: width, height: height);
//     return ViewModelBuilder<SignUpViewModel>.reactive(
//       builder: (context, model, child) => Scaffold(
//         key: _pageKey,
//         body: HomeBackgrouWidget(
//           context: context,
//           height: height,
//           width: width,
//           widget: Form(
//             key: _formPageKey,
//             child: Column(
//               children: <Widget>[
//                  SizedBox(height: SizeConfig.yMargin(context, 7)),
//                 Text(
//                   'SIGN UP',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w900,
//                     fontSize: SizeConfig.yMargin(context, 4),
//                   ),
//                 ),
//                 SizedBox(height: SizeConfig.xMargin(context, 4)),
//                 Text(
//                   'Please Enter your Phone number',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: SizeConfig.yMargin(context, 2),
//                   ),
//                 ),
//                 // SizedBox(height: SizeConfig.yMargin(context, 0.2)),
//                 // Container(
//                 //     height: SizeConfig.yMargin(context, 60),
//                 //     width: SizeConfig.xMargin(context, 90),
               
//                 // ),
//                 SizedBox(height: SizeConfig.yMargin(context, 5)),
//                 Padding(
//                   padding: EdgeInsets.all(
//                     SizeConfig.yMargin(context, 0.8),
//                   ),
//                   child: 
//                 Row(
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       // Expanded(
//                       //   flex: 1,
//                       //   child: DropdownButton<String>(
//                       //     value: model.dropdownValue,
//                       //     icon: Icon(Icons.keyboard_arrow_down),
//                       //     iconSize: 25.w,
//                       //     elevation: 16,
//                       //     onChanged: (String data) {
//                       //       model.setDropdownValue(data);
//                       //     },
//                       //     items: model.dropdownItems
//                       //         .map<DropdownMenuItem<String>>((String value) {
//                       //       return DropdownMenuItem<String>(
//                       //         value: value,
//                       //         child: Text(value),
//                       //       );
//                       //     }).toList(),
//                       //   ),
//                       // ),
//                       // Container(
//                       //   width: SizeConfig.xMargin(context, 10),
//                       //   color: Colors.black,
//                       // ),
//                       Expanded(
//                         child: TextFormField(
//                           key: Key('num'),
//                           controller: _inputNumberController,
//                           validator: (value) => (value.isEmpty)
//                               ? "Please Enter Phone Number"
//                               : null,
//                           style:
//                               TextStyle(fontFamily: 'Roboto', fontSize: 20.0),
//                           decoration:
//                               InputDecoration(border: OutlineInputBorder()),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: SizeConfig.yMargin(context, 3)),
//                 Text(
//                   'or Continue with your social accounts',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF02034A),
//                     fontSize: 16.sp,
//                   ),
//                 ),
//                 SizedBox(height: SizeConfig.yMargin(context, 3)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SocialIconButton(
//                       onTap: () {},
//                       socialIconUrl: 'assets/icons/google_icon.png',
//                     ),
//                     SocialIconButton(
//                       onTap: () {},
//                       socialIconUrl: 'assets/icons/facebook_icon.png',
//                     ),
//                     SocialIconButton(
//                       onTap: () {},
//                       socialIconUrl: 'assets/icons/apple_icon.png',
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: SizeConfig.yMargin(context, 2)),
//                 btnAuth('Next', context),
//                 SizedBox(height: SizeConfig.yMargin(context, 2)),
//                 Row(
//                   children: <Widget>[
//                     Text(
//                       'Already have an account?',
//                       style: TextStyle(
//                         color: Color(0xFF2F80ED),
//                         fontSize: SizeConfig.yMargin(context, 2),
//                       ),
//                     ),
//                     SizedBox(width: SizeConfig.xMargin(context, 1)),
//                     InkWell(
//                       onTap: () {
//                         //TODO: Implement Navigation to Login
//                       },
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           color: Color(0xFF2F80ED),
//                           fontSize: SizeConfig.yMargin(context, 2),
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
      
//       viewModelBuilder: () => SignUpViewModel(),
//     );
//   }

//   Widget inputNumberBottomWidget(
//       double height, SignUpViewModel model, BuildContext context) {
//     return Container(
//       height: height / 2,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text(
//               'Please, Enter your Phone Number',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.sp,
//               ),
//             ),
//             SizedBox(
//               width: 5.h,
//             ),
//             Container(
//               height: 50.h,
//               decoration: BoxDecoration(
//                 color: Colors.grey[400].withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(10.w),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               child: Row(
//                 children: <Widget>[
//                   DropdownButton<String>(
//                     value: model.dropdownValue,
//                     icon: Icon(Icons.keyboard_arrow_down),
//                     iconSize: 25.w,
//                     elevation: 16,
//                     onChanged: (String data) {
//                       model.setDropdownValue(data);
//                     },
//                     items: model.dropdownItems
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   Container(
//                     width: 1.w,
//                     color: Colors.black.withOpacity(0.3),
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       key: _k1,
//                       keyboardType: TextInputType.phone,
//                       controller: _inputNumberController,
//                       decoration: InputDecoration(
//                           border: InputBorder.none, hintText: 'Phone Number'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 5.h,
//             ),
//             Text(
//               'or Continue with your social accounts',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Color(0xFF02034A),
//                 fontSize: 16.sp,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SocialIconButton(
//                   onTap: () {},
//                   socialIconUrl: 'assets/images/google_icon.png',
//                 ),
//                 SocialIconButton(
//                   onTap: () {},
//                   socialIconUrl: 'assets/images/facebook_icon.png',
//                 ),
//                 SocialIconButton(
//                   onTap: () {},
//                   socialIconUrl: 'assets/images/apple_icon.png',
//                 ),
//               ],
//             ),
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) => SingleChildScrollView(
//                     child: Container(
//                       padding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.bottom),
//                       child: Stack(alignment: Alignment.center, children: [
//                         modalBottomWidget(height, model, context),
//                         Center(child: _LoadingAnimation()),
//                       ]),
//                     ),
//                   ),
//                 );
//                 model.init();
//               },
//               child: Container(
//                 height: 50.h,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF333CC1),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Next',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     SizedBox(width: 10.h),
//                     Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget modalBottomWidget(
//       double height, SignUpViewModel model, BuildContext context) {
//     return Container(
//       height: height / 2.0,
//       color: Colors.black,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF263BBA),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.w),
//             topRight: Radius.circular(24.w),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             SizedBox(height: 10.h),
//             Text(
//               'PASTE FROM SMS',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.sp,
//               ),
//             ),
//             SizedBox(height: 5.h),
//             Text(
//               '0349',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.sp,
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(32.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24.0),
//                     topRight: Radius.circular(24.0),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     PinCodeTextField(
//                       length: 4,
//                       obsecureText: false,
//                       animationType: AnimationType.scale,
//                       textInputType: TextInputType.number,
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.underline,
//                         selectedColor: Colors.black,
//                         activeColor: Colors.black,
//                         inactiveColor: Colors.grey,
//                         borderWidth: 1,
//                         fieldWidth: ScreenUtil.screenWidthDp * 0.15,
//                       ),
//                       animationDuration: Duration(milliseconds: 300),
//                       //errorAnimationController: errorController,
//                       //controller: textEditingController,
//                       autoDisposeControllers: false,
//                       onCompleted: (v) {},
//                       onChanged: (value) {
//                         //TODO: Listens and Obey
//                       },
//                     ),
//                     Center(
//                       child: Text(
//                         'Please enter 4-digit code we sent on \nyour number as SMS',
//                         style: TextStyle(
//                           fontFamily: 'Lato',
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LoadingAnimation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: LoadingAnimation(),
//     );
//   }
// }
