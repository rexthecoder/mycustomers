import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_image.dart';
import 'package:mycustomers/ui/shared/const_text.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'add_customer_viewmodel.dart';

class AddCustomerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomerViewModel>.reactive(
        builder: (context, model, child) => PlatformScaffold(
              body: SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      // ======================= Heading section Start here ==================
                      Row(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                color: kblack,
                                icon: Icon(Icons.arrow_back),
                                onPressed: (){
                                  model.navigateToHome();
                                }
                                ),
                          ),
                          Container(
                            child: Text(kaddCustomerHeadingText,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kblack,
                                )),
                          )
                        ],
                      ),
// ======================== Heading Section End here ==================================

// ======================== Center Section Start here ==================================
                      SizedBox(
                        height: 150,
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: kaddCustomerImage,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: Text(
                                kaddCustomerBodyText1,
                                style: bodyTextStyle(FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                kaddCustomerBodyText2,
                                style: bodyTextStyle(FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // ======================== Center Section End here ==================================
                      Column(
                        children: <Widget>[
                          btnDesign(model.btnText1, Colors.white, kblue),
                          SizedBox(
                            height: 30,
                          ),
                          btnDesign(model.btnText2, kblue, kwhiteAsh),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => AddCustomerViewModel());
  }
}
