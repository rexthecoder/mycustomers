import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'business_viewmodel.dart';

class BusinessView extends StatelessWidget  {
  
  static final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  TextEditingController _userFullName;
  TextEditingController _userBusinessName;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<BusinessViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _pageKey,
        body: HomeBackgroundWidget(
          height: height,
          width: width,
          child: Form(
            key: _formPageKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.yMargin(context, 7)),
                Text(
                  'BUSINESS DETAILS',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 4),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 5)),
                Text(
                  'One last step...',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 2),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 2)),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                  child: TextFormField(
                    key: Key("userFullName"),
                    controller: _userFullName,
                    validator: (value) =>
                        (value.isEmpty) ? "Please Enter Full Name" : null,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: SizeConfig.yMargin(context, 2),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        labelText: "Enter Your Full Name",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                  child: TextFormField(
                    key: Key("userBusinessName"),
                    controller: _userBusinessName,
                    validator: (value) =>
                        (value.isEmpty) ? "Please Enter Business Name" : null,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: SizeConfig.yMargin(context, 2),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        labelText: "Enter Your Business Name",
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 4)),
                InkWell(
                    onTap: () {
                      if (_formPageKey.currentState.validate()) {
                        model.navigateToNext();
                      }
                    },
                    child: btnAuth('Submit and Finish', context)),
                SizedBox(height: SizeConfig.yMargin(context, 14)),
                Container(
                    width: SizeConfig.xMargin(context, 60),
                    child: CustomizeProgressIndicator(3, 4)),
                SizedBox(height: SizeConfig.yMargin(context, 4)),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessViewModel(),
    );
  }
}
