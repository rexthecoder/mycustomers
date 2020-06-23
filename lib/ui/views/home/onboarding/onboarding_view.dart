import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:stacked/stacked.dart';
import 'onboarding_viewmodel.dart';
import 'package:flutter_screenutil/size_extension.dart';

class OnboardingView extends StatelessWidget {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: height / 2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/onboarding/ob1.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: height / 2.0,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[],
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

//     builder: (context, model, child) => Scaffold(
//       body: Container(
//         height: height,
//         child: Stack(
//           //alignment: Alignment.center,
//           children: <Widget>[
//             PageView(
//               physics: ClampingScrollPhysics(),
//               onPageChanged: model.onChangedFunction,
//               controller: _pageController,
//               children: [
//                 //       _pages('assets/images/onboarding/onboarding1.png'),

//                               //   _pages('assets/images/onboarding/onboarding2.png'),
//                //   _pages('assets/images/onboarding/onboarding3.png'),
//                 Row(
//                   children: <Widget>[
//                     Container(
//                       height: height / 2,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/images/onboarding/onboarding1.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//     viewModelBuilder: () => OnboardingViewModel(),
//   );
// }

// Widget _pages(image) {
//   // return Container(
//   //   height: height/2,
//   //   decoration: BoxDecoration(
//   //     image: DecorationImage(
//   //       image: AssetImage(image),
//   //       fit: BoxFit.cover,
//   //     ),
//   //   ),
//   // );
// }
// }

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color:
              positionIndex == currentIndex ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

// Positioned(
//   bottom: 270,
//   // left: 150.h,
//   child: Row(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: <Widget>[
//       Indicator(
//         positionIndex: 0,
//         currentIndex: model.currentIndex,
//       ),
//       SizedBox(
//         width: 10,
//       ),
//       Indicator(
//         positionIndex: 1,
//         currentIndex: model.currentIndex,
//       ),
//       SizedBox(
//         width: 10,
//       ),
//       Indicator(
//         positionIndex: 2,
//         currentIndex: model.currentIndex,
//       ),
//     ],
//   ),
// ),
// Positioned(
//   bottom: 180.h,
//   child: Image(
//     height: 50.h,
//     fit: BoxFit.contain,
//     image: AssetImage(
//       'assets/images/onboarding/whitelogo1.png',
//     ),
//   ),
// ),
// Positioned(
//   bottom: 50.h,
//   child: InkWell(
//     onTap: () {
//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           0,
//           duration: const Duration(milliseconds: 400),
//           curve: Curves.easeInOut,
//         );
//       }
//       //   model.nextFunction();
//     },
//     child: Container(
//       height: 50.h,
//       width: 300.w,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Color(0xFF333CC1)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Get Started',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16.sp,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
