import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_viewmodel.dart';
import 'package:mycustomers/core/models/customer.dart';

class QuickMessageView extends StatelessWidget {
  final List<Customer> selectedCustomers = [];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickMessageViewModel>.reactive(
      viewModelBuilder: () => QuickMessageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).sendMessage,
              arrowColor: BrandColors.primary,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //TODO: Localize quickText
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: quickMessageTitle.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.yMargin(context, 2),
                      ),
                      FlatButton(
                        onPressed: () => model.navigateToMessageView(
                            //selectedCustomers,
                            quickMessageTitle[index],
                            quickMessageText[index]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: BrandColors.secondary.withOpacity(0.5))),
                        child: Container(

                          height: SizeConfig.yMargin(context, 15),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        quickMessageTitle[index],
                                        style: TextStyle(
                                          fontSize: SizeConfig.textSize(context, 4.2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height:  SizeConfig.yMargin(context, 1),
                                      ),
                                      Text(
                                        quickMessageText[index],
                                        style: TextStyle(
                                          fontSize:SizeConfig.textSize(context, 4.2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:  SizeConfig.yMargin(context, 0.5),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  size:  SizeConfig.xMargin(context, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:  SizeConfig.yMargin(context, 1),),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context).seeAll,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: BrandColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textSize(context, 4),
                    ),
                  ),
                ),
                SizedBox(height:  SizeConfig.yMargin(context, 6),),
                FlatButton(
                  color: BrandColors.primary,
                  onPressed: () {
                    model.navigateToMessage(
                      //selectedCustomers,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).composeMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.textSize(context, 4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
