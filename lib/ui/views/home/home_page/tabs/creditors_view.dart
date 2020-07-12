
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import '../home_page_viewmodel.dart';

class CreditorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    final currency = new NumberFormat("#,##0", "en_NG");
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 4.0)),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: BrandColors.secondary,
                            image: DecorationImage(
                              image: ExactAssetImage('assets/images/orange_banner.png',
                              ),
                              fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('You are owing customers', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp
                              ),),
                              model.whatyouowe > 0 ? Text(
                                '₦'+currency.format(model.whatyouowe).toString(),
                                style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                              ) : RichText(
                                text: TextSpan(
                                    text: 'NGN 0.', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '00.', style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold
                                      ),
                                      )
                                    ]
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
//                      Text('Current Creditors', style: TextStyle(
//                          color: Colors.black,
//                          fontSize: 20.sp,
//                          fontWeight: FontWeight.bold
//                      ),),
//                      SizedBox(height: 5.h,),
//                      Text('These are the people you are owing', style: TextStyle(
//                        color: Color(0xFFACACAC),
//                        fontSize: 12.sp,
//
//                      ),),
//                      SizedBox(height: 20.h,),
//                      Container(
//                        height: 50.h,
//                        width: MediaQuery.of(context).size.width,
//                        child: TextField(
//                          controller: model.creditorsController,
//                          onChanged: model.searchCreditors,
//                          style:  TextStyle(
//                            color: Colors.black,
//                            fontSize: 12.sp,),
//                          decoration: InputDecoration(
//                            hintText: 'Search for a creditor',
//                            hintStyle: TextStyle(
//                              color: Color(0xFFACACAC),
//                              fontSize: 12.sp,
//
//                            ),
//                            contentPadding:  const EdgeInsets.all(8.0),
//                            prefixIcon:   Icon(Icons.search,color: Color(0xFFACACAC),),
//                            border: OutlineInputBorder(
//                              borderSide: BorderSide(color:  Color(0xFFACACAC),),
//                              borderRadius: BorderRadius.circular(5),
//                            ),
//                            focusedBorder:  OutlineInputBorder(
//                              borderSide: BorderSide(color:  BrandColors.secondary,),
//                              borderRadius: BorderRadius.circular(5),
//                            ),
//
//                          ),
//                        ),
//                      ),
//                      SizedBox(height: 20.h,),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Text('Sorted by:', style: TextStyle(
//                                color: Color(0xFF31393C),
//                                fontSize: 14.sp,
//                              ),),
//                              Text('Date of issue', style: TextStyle(
//                                color: Color(0xFF2D74DA),
//                                fontSize: 14.sp,
//                              ),),
//                            ],
//                          ),
//                          InkWell(
//                            onTap: (){},
//                            child: Row(
//                              children: <Widget>[
//                                Icon(Icons.filter_list, ),
//                                Text('Filter', style: TextStyle(
//                                  color: Color(0xFF2D74DA),
//                                  fontSize: 14.sp,
//                                ),),
//                              ],
//                            ),
//                          ),
//
//                        ],),
//                      Container(
//                        height: 100,
//                        child: Center(child: Text('You don\'t have any creditors yet')),),
                      model.owedcustomers.length == 0 ? Container(
                        height:height/2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset('assets/images/Notebook-pana 1.png'),
                              SizedBox(height: 20.h,),
                              Text('You don\'t owe any customer. Tap the big blue button at the bottom of the screen to add one',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: BrandColors.secondary),),
                            ],
                          ),
                        ),
                      ) : ContactList(),
                          

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: InkWell(
//                onTap: ()=> Navigator.pushNamed(context, '/sendReminder'),
                onTap: ()=> Navigator.pushNamed(context, '/importcustomercreditor'),
                child: Container(
                  height: 50.h,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: BrandColors.secondary,
                    borderRadius: BorderRadius.circular(5)
                  ),

                  child: Center(
                    child: Text('Add customer you owe',
                      style: TextStyle(color: Colors.white,
                      fontSize: 12.sp,),
                    ),
                  ),
                ),
              ),
            )
          ] ,
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}

class ContactList extends StatelessWidget {
  final currency = new NumberFormat("#,##0", "en_NG");
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Container(
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
                onChanged: model.searchCName,
              ),
            ),
            model.sCName != null && !model.containsC ? Text(
              'No Customer Found'
            ) : SizedBox(),
            for(var cont in model.owedcustomers)
              for (var item in model.contacts) item.id == cont.cId ? 
              model.sCName != null && model.containsC ? 
              item.name.toLowerCase().contains(model.sCName.toLowerCase()) ?
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
                    onTap: () => model.setContact(item.id, item.name, item.phoneNumber, item.initials),
                    leading: item.initials != null ? CircleAvatar(
                      radius: 25,
                      backgroundColor: BrandColors.primary,
                      child: Text(
                        item.initials
                      ),
                    ) : Container(
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
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.w600)
                    ),
                    /*subtitle: Text(
                      DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7 == 0 ?(DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7).toString()+' weeks' : (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays).toString()+' days'
                    ),*/
                    trailing: Container(
                      child: Text(
                        '₦'+currency.format((cont.paid - cont.amount).round()).toString(),
                        style: TextStyle(
                          color: (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays) > 0 ? Colors.red : Colors.green, 
                          fontSize: 16,
                          fontFamily: 'Roboto'
                        ),
                      ),
                    ),
                  ),
                ),
              ) : SizedBox()
              : 
              model.sCName !=null && !model.containsC ? 
              SizedBox() 
              :
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
                  onTap: () => model.setContact(item.id, item.name, item.phoneNumber, item.initials),
                  leading: item.initials != null ? CircleAvatar(
                      radius: 25,
                      backgroundColor: BrandColors.primary,
                      child: Text(
                        item.initials
                      ),
                    ) : Container(
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
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.w600)
                  ),
                  /*subtitle: Text(
                    DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7 == 0 ?(DateTime.now().difference(DateTime.parse(cont.duedate)).inDays % 7).toString()+' weeks' : (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays).toString()+' days'
                  ),*/
                  trailing: Container(
                    child: Text(
                      '₦'+currency.format((cont.paid - cont.amount).round()).toString(),
                      style: TextStyle(
                        color: (DateTime.now().difference(DateTime.parse(cont.duedate)).inDays) > 0 ? Colors.red : Colors.green, 
                        fontSize: 16,
                        fontFamily: 'Roboto'
                      ),
                    ),
                  ),
                ),
              ),
            ) : SizedBox()
          ],
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}