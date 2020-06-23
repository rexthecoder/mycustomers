import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/screenutil.dart';

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
                                fontSize: ScreenUtil().setSp(18))),
                        SizedBox()
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(78)),
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
                                        fontSize: ScreenUtil().setSp(16)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setHeight(16),
                                        20,
                                        0,
                                        ScreenUtil().setHeight(16)),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: ScreenUtil().setHeight(15)),
                            TextFormField(
                              validator: (value) => model.validateFields(value),
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(16)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setHeight(16),
                                        20,
                                        0,
                                        ScreenUtil().setHeight(16)),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Container(
                                // padding: EdgeInsets.fromLTRB(20, 16, 0, 16),
                                height: MediaQuery.of(context).size.width > 375
                                    ? ScreenUtil().setHeight(52)
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
                                            fontSize: ScreenUtil().setSp(18)),
                                      ),
                                      new DropdownButton<String>(
                                        underline: SizedBox(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                        elevation: 0,
                                        // isExpanded: t,
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
                            SizedBox(height: ScreenUtil().setHeight(19)),
                            TextFormField(
                              validator: (value) => model.validateFields(value),
                                minLines: 8,
                                maxLines: 12,
                                decoration: InputDecoration(
                                    hintText: 'Write Your Message Here',
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(16)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setHeight(16),
                                        20,
                                        0,
                                        ScreenUtil().setHeight(16)),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(11.0),
                                      borderSide: new BorderSide(
                                          color: Color(0xffd1d1d1), width: 2),
                                    ))),
                            SizedBox(height: ScreenUtil().setHeight(31)),
                          ],
                        )),
                    RaisedButton(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(16),
                          bottom: ScreenUtil().setHeight(16)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          print('valid');
                        }
                      },
                      child: Text('Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16))),
                      color: Color(0xff333cc1),
                    )
                  ]),
                ),
              ),
            ),
        viewModelBuilder: () => SupportPageViewModel());
  }
}
