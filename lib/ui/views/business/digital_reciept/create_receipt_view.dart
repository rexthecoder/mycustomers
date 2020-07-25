import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/partial_build.dart';
import 'package:stacked/stacked.dart';
import 'package:worm_indicator/shape.dart';
import 'package:worm_indicator/worm_indicator.dart';

import 'create_receipt_viewmodel.dart';

class CreateReceiptView extends StatelessWidget {
  
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateReceiptViewModel>.nonReactive(
      builder: (context, model, child) {
        bool val = false;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(
            context,
            1.0,
            children: [],
            title: 'Digital Receipt',
            arrowColor: BrandColors.primary,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 25.0, right:  23.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Create a receipt',
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: SizeConfig.yMargin(context, 3.9),
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                    )
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Text('Lets get started',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
//                    Positioned(
//                      bottom: SizeConfig.yMargin(context, 20),
//                      left: 0,
//                      right: 0,
//                      child: WormIndicator(
//                        indicatorColor: BrandColors.primary,
//                        color: ThemeColors.gray.shade800,
//                        length: 4,
//                        controller: model.pageController,
//                        shape: Shape(
//                          size: SizeConfig.yMargin(context, 1),
//                          shape: DotShape.Rectangle,
//                          spacing: SizeConfig.xMargin(context, 3),
//                        ),
//                      ),
//                    ),
                    //TODO: PAGECONTROLLER   HERE
                    Row(
                      children: <Widget>[
                        Container(),
                        Container(),
                        Container()
                      ],
                    ),
                    SizedBox(
                      //height: 25,
                      height: SizeConfig.xMargin(context, 6),
                    ),
                    Text('Category',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Text('This helps you track your sales from different platforms',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 3),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.xMargin(context, 2))),
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                          ),

                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left:15),
                          child: Text('Categories',
                            style: TextStyle(
                              fontSize: SizeConfig.yMargin(context, 2.9),
                              fontFamily: 'montserrat',
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                            ),
                          ),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(right:15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).cursorColor,
                          ),
                        ),
                        elevation: 0,
                        isDense: false,
                        items:
                        (model.categories).map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (category) {
                          //TODO: implement dropdown
                          model.setItem(category);
                          print(model.category);
                        },
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.xMargin(context, 7),
                    ),
                    Text('Customer information',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Text('This is a display of the receipt',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      //height: 13,
                      height: SizeConfig.xMargin(context, 5),
                    ),


                    Text('Customer name',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                             Radius.circular(SizeConfig.xMargin(context, 2))),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                          )
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                      //height: 13,
                      height: SizeConfig.xMargin(context, 5),
                    ),

                    Text('Email address',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.xMargin(context, 2))),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                              )
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      //height: 13,
                      height: SizeConfig.xMargin(context, 5),
                    ),

                    Text('Address',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.xMargin(context, 2))),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                              )
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      //height: 13,
                      height: SizeConfig.xMargin(context, 5),
                    ),

                    Text('Phone number',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        //fontSize: 14,
                        fontSize: SizeConfig.yMargin(context, 2.5),
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 1),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.xMargin(context, 2))),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('save to customer list',
                        style: TextStyle(
                          //fontSize: 16,
                          fontSize: SizeConfig.yMargin(context, 2.9),
                          fontFamily: 'montserrat',
                        ),
                        ),
                        Switch(value: val, onChanged: (newVal){

                        })
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.xMargin(context, 5),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                          )),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left:15),
                          child: Text('Select Currency',
                          style: TextStyle(
                            fontSize: SizeConfig.yMargin(context, 2.9),
                            fontFamily: 'montserrat',
                            color: Color.fromRGBO(0, 0, 0, 0.87),
                          ),
                          ),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(right:15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).cursorColor,
                          ),
                        ),
                        elevation: 0,
                        isDense: false,
                        items:
                        (model.currencies).map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (currency) {
                          //TODO: implement dropdown
                          model.setItem(currency);
                          print(model.currency);
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 5),
                    ),

                    CustomRaisedButton(
                      txtColor: ThemeColors.background,
                      btnColor: BrandColors.primary,
                      btnText: 'Next',
                      borderColor: BrandColors.primary,
                      child: Container(),
                      onPressed: () {
                        // Leave the funtionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CreateReceiptViewModel(),
    );
  }

}
