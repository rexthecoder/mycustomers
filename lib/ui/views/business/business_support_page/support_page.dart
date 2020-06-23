import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'support_page_viewmodel.dart';

class SupportPageView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController k = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
    return ViewModelBuilder<SupportPageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.arrow_back),
                        Text('Customer Support',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp)),
                        SizedBox()
                      ],
                    ),
                    SizedBox(height: 78.h),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // Expanded(child: null),
                            TextFormField(
                              validator: (value) => model.validateFields(value),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                        fontSize: 16.sp),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.h,
                                        20,
                                        0,
                                        16.h),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: 15.h),
                            TextFormField(
                              validator: (value) => model.validateFields(value),
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontSize: 16.sp),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.h,
                                        20,
                                        0,
                                        16.h),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: 20.h),
                            Container(
                                // padding: EdgeInsets.fromLTRB(20, 16, 0, 16),
                                height: MediaQuery.of(context).size.width > 375
                                    ? 52.h
                                    : 52,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Color(0xffd1d1d1),
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 23),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        model.item,
                                        style: TextStyle(
                                            color: Color(0xff8c8c8c),
                                            fontSize: 18.sp),
                                      ),
                                      new DropdownButton<String>(
                                        underline: SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                        elevation: 0,
                                        isDense: false,
                                        items: (model.items).map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (item) {
                                          //TODO: implement dropdown
                                          model.setItem(item);
                                          print(model.item);
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(height: 19.h),
                            TextFormField(
                              validator: (value) => model.validateFields(value),
                                minLines: 8,
                                maxLines: 12,
                                decoration: InputDecoration(
                                    hintText: 'Write Your Message Here',
                                    hintStyle: TextStyle(
                                        fontSize: 16.sp),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.h,
                                        20,
                                        0,
                                        16.h),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(11.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: 31.h),
                          ],
                        )),
                    RaisedButton(
                      padding: EdgeInsets.only(
                          top: 16.h,
                          bottom: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // TODO: Implement Send report service 
                        }
                      },
                      child: Text('Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp)),
                      color: Color(0xff333cc1),
                    )
                  ]),
                ),
              ),
            ),
        viewModelBuilder: () => SupportPageViewModel());
  }
}
