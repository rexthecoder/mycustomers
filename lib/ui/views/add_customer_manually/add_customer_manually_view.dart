import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mycustomers/ui/views/add_customer_manually/partial_build_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_customer_manually_viewmodel.dart';


class AddCustomerManuallyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.height;
    
    return ViewModelBuilder<AddCustomerManuallyViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: PlatformAppBar(
          backgroundColor: Color(0xfffafafa),
          material: (_, __) {
            return MaterialAppBarData(
              centerTitle: false,
              elevation: 0,
            );
          },
          title: Center(
            child: Text(model.title,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'assets/fonts/Lato/Lato-Bold',
              color: Color(0xff000000)
            ),),
          ),
          
        ),
        body: SafeArea(
          child: Container(
            height: size*0.45,
            decoration: BoxDecoration(
              border: Border(top:BorderSide(
                color: Color(0xffE8E8E8),
                width: 1.5
              ))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Expanded(
                                child: Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: Text(model.subTitle,
                   style:TextStyle(
                     fontSize:18.sp,
                     fontFamily:'assets/fonts/Lato/Lato-Regular',
                     color: Color(0xff000000)
                   )),
                 ),
               ),

               Expanded(child: PartialBuildsView()),
              
               Expanded(
                                child: Center(
                   child: ButtonTheme(
                     minWidth: 300,
                       child: RaisedButton(
                       color: Color(0xff333CC1),
                       onPressed: (){},
                       shape: RoundedRectangleBorder(
                         borderRadius:BorderRadius.circular(5.0)
                       ),
                       child: Text('Next',
                       style:TextStyle(
                         fontSize:16.sp,
                         fontWeight:FontWeight.w800,
                         fontFamily:'assets/fonts/Lato/Lato-Regular',
                         color: Color(0xFFFFFFFF)
                       )),
                       ),
                   ),
                 ),
               )
             ],),
          ),
         ),
      ),
      viewModelBuilder: () => AddCustomerManuallyViewModel(),
    );
  }
}



