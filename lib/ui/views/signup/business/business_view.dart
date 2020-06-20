import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'business_viewmodel.dart';

class BusinessView extends StatelessWidget {
 TextEditingController inputNumberController = new TextEditingController();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<BusinessViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _key,
        body: SingleChildScrollView(
                  child: Container(
            height: height / 2,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/auth_background.png',
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/heading2.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
//        bottomSheet: inputNameBottomWidget(height, model, context),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: inputBusinessBottomWidget(height, model, context),
        ),
//        bottomSheet: modalBottomWidget(height),
      ),
      viewModelBuilder: () => BusinessViewModel(),
    );
  }

  Widget inputBusinessBottomWidget(
      double height, BusinessViewModel model, BuildContext context) {
    return Container(
      height: height / 2.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "What's The Name of Your Business",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.w),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Container(width: 30.w),
                  Container(
                    width: 1.w,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: TextField(
                      controller: inputNumberController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Business Name'),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    model.navigateBack();
                  },
                  child: Container(
                    height: 50.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF000E66)),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      model.navigateForward();
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF333CC1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Finish',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 10.h),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
