import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'send_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class SendMessage extends StatelessWidget {
  final headingController = new TextEditingController();
  final messageHeadingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return ViewModelBuilder<SendMessageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendReminder,
              arrowColor: Theme.of(context).textSelectionColor,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.yMargin(context, 5),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: TextFormField(
                                    controller: headingController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .fieldShouldNotBeEmpty;
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        height:
                                            SizeConfig.yMargin(context, 0.2)),
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .typeAHeading,
                                      hintStyle: TextStyle(
                                          color: BrandColors.greyedText),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.yMargin(context, 3)),
                                SizedBox(
                                    height: SizeConfig.yMargin(context, 6),
                                    child: messageSnippetHolder(
                                        context, model, headingController)),
                                SizedBox(
                                    height: SizeConfig.yMargin(context, 5)),
                                Container(
                                  child: TextFormField(
                                    controller: messageHeadingController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .fieldShouldNotBeEmpty;
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        height:
                                            SizeConfig.yMargin(context, 0.18)),
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .startTypingYourmessage,
                                      hintStyle: TextStyle(
                                          color: BrandColors.greyedText),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColors.gray,
                                            width: 2.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 3)),
                Container(
                  height: 50,
                  color: Theme.of(context).backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: CustomRaisedButton(
                          txtColor: BrandColors.primary,
                          btnColor: ThemeColors.background,
                          btnText: AppLocalizations.of(context).schedule,
                          borderColor: BrandColors.primary,
                          child: Container(),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/scheduleNotifications');
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomRaisedButton(
                          txtColor: ThemeColors.background,
                          btnColor: BrandColors.primary,
                          btnText: AppLocalizations.of(context).sendCapital,
                          borderColor: BrandColors.primary,
                          child: Container(),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              flusher(
                                  'Send message still in development', context);
                              model.clearMessageFields();
                              headingController.text = model.controllerValue;
                              messageHeadingController.text =
                                  model.messageControllerValue;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SendMessageViewModel(),
    );
  }
}

Widget messageSnippet(String value, SendMessageViewModel model,
    BuildContext context, TextEditingController controllerValue) {
  return Container(
      margin: EdgeInsets.only(left: SizeConfig.yMargin(context, 1.2)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: ThemeColors.unselect),
      child: FlatButton(
          onPressed: () {
            model.updateFieldValue(value);
            controllerValue.text = model.controllerValue;
          },
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: BrandColors.primary,
                fontSize: SizeConfig.textSize(context, 4)),
          )));
}

Widget messageSnippetHolder(BuildContext context, SendMessageViewModel model,
    TextEditingController controllerValue) {
  return ListView.builder(
      itemCount: model.messageEntries.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, int index) {
        return messageSnippet(
            model.messageEntries[index], model, context, controllerValue);
      });
}
