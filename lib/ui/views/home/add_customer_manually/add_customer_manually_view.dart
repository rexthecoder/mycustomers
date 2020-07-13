import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'add_customer_manually_viewmodel.dart';

class AddCustomerManuallyView extends StatelessWidget {
  final String action;

  const AddCustomerManuallyView({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
  return ViewModelBuilder<AddCustomerManuallyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: ThemeColors.background,
        appBar: AppBar(
          backgroundColor: ThemeColors.background,
          centerTitle: true,
          elevation: 1,
          title: Text(
            model.title,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors.black,
            ),
          ),
          iconTheme: IconThemeData(color: ThemeColors.black),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.subTitle,
                  style: TextStyle(fontSize: 18, color: ThemeColors.black),
                ),
                SizedBox(height: 16.0),
                _StringForm(action: action,),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                    onPressed: () {
                      model.addContact(action);
                      //Navigator.pushNamed(context, '/mainTransaction');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AddCustomerManuallyViewModel(),
    );
  }
}

class _StringForm extends HookViewModelWidget<AddCustomerManuallyViewModel> {
  final String action;
  _StringForm({Key key, this.action}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context, AddCustomerManuallyViewModel model) {
    var name = useTextEditingController();
    var phoneNumber = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff77869e),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
                  ),
                ),
                Container(
                  height: 24.0,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xff77869e),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      controller: name,
                      onChanged: model.updateName,
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: 16.0),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff77869e),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: model.dropDownValue,
                    items: model.countryCode
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      model.updateCountryCode(newValue);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                    height: 24.0,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Color(0xff77869e))))),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: phoneNumber,
                    onChanged: model.updateContact,
                  ),
                )
              ],
            )),
      ],
    );
  }
}
