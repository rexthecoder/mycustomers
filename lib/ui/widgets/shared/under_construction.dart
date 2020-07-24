import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

class UnderConstruction extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300.w,
                  height: 250.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/404.png',
                      ),
                    ),
                  ),
                ),
                Text(
                  'Under Construction',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  'Team Justice League \n MB Devs At Work!!!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        );
  }


}