import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'add_new_customer_viewmodel.dart';

class AddNewCustomerView extends StatelessWidget {
  final GlobalKey<FormState> _newCusForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewCustomerViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: customizeAppBar(
              context,
              1.0,
              title: AppLocalizations.of(context).sendMessage,
              arrowColor: BrandColors.secondary,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _newCusForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).customerName,
                      style:
                          TextStyle(fontSize: SizeConfig.textSize(context, 4), color: ThemeColors.black),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.gray,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              textAlign: TextAlign.left,
                              style:TextStyle(

                                fontSize: SizeConfig.textSize(context, 4),
                              ),
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .enterCustomerName,
                                prefixIcon: Icon(Icons.person, size: SizeConfig.xMargin(context, 6),),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              controller: model.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        )),
                    SizedBox(height: 16.0),
                    Text(
                      AppLocalizations.of(context).customerPhoneNo,
                      style:
                          TextStyle(fontSize: SizeConfig.textSize(context, 4), color: ThemeColors.black),
                    ),
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
//                            Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Icon(Icons.phone_android,
//                                    color: ThemeColors.gray)),
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: DropdownButton<String>(
//                                underline: Container(),
//                                value: model.dropDownValue,
//                                items: model.countryCode
//                                    .map<DropdownMenuItem<String>>(
//                                        (String value) {
//                                  return DropdownMenuItem<String>(
//                                    value: value,
//                                    child: Text(value),
//                                  );
//                                }).toList(),
//                                onChanged: (String newValue) {
//                                  model.updateCountryCode(newValue);
//                                },
//                                icon: Icon(
//                                  Icons.arrow_drop_down,
//                                  color: Color(0xff000000),
//                                ),
//                              ),
//                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InternationalPhoneNumberInput(
                                textStyle: TextStyle(
                                  fontSize: SizeConfig.textSize(context, 4),
                                ),
                                  selectorTextStyle: TextStyle(
                                    fontSize: SizeConfig.textSize(context, 4),
                                  ),
                                  inputDecoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context).mobileNumber,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  textFieldController: model.phoneNumber,
                                  onInputChanged: model.updateContact,
                                  keyboardAction: TextInputAction.done,
                                ),
                              ),
                            )
                          ],
                        )),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        color: BrandColors.primary,
                        onPressed: () {
                          //Dismiss keyboard during async call
                          FocusScope.of(context).requestFocus(FocusNode());
                          !_newCusForm.currentState.validate() ? flusher(
                            //TODO Localize valid values
                              'Enter valid values',
                              context) :
                          !model.validateName()
                                  ? flusher(
                                      AppLocalizations.of(context)
                                          .enterCustomerName,
                                      context)
                                  : model.returnHome();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          AppLocalizations.of(context).continueButton,
                          style: TextStyle(
                              fontSize: SizeConfig.textSize(context, 3),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => AddNewCustomerViewModel());
  }
}
