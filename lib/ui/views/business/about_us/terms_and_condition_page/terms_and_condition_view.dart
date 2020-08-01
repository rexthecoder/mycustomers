import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'terms_and_condition_viewmodel.dart';

class TermsAndConditionView extends StatelessWidget {
  final String myCustomerLogo = 'assets/icons/svg/customerpaymelogo.svg';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsAndConditionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: customizeAppBar(context, 1,
            title: 'TERMS & CONDITIONS', backgroundColor: Theme.of(context).backgroundColor),
        body: Container(
          margin: EdgeInsets.only(
              right: SizeConfig.xMargin(context, 5),
              left: SizeConfig.xMargin(context, 5),
              top: SizeConfig.yMargin(context, 2),
              bottom: SizeConfig.yMargin(context, 2)),
          child: Column(
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  myCustomerLogo,
//                  color: ThemeColors.background,
                  height: SizeConfig.yMargin(context, 14),
                ),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 3),
              ),
              Text(
                'TERMS & CONDITIONS OF USE',
                style: TextStyle(
                    color: Theme.of(context).cursorColor,
                    fontSize: SizeConfig.textSize(context, 5),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: SizeConfig.yMargin(context, 1),
              ),
              Text('DATE OF LAST UPDATE: [31st July, 2020]'),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.yMargin(context, 3),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.yMargin(context, 3),
                        ),
                        container(
                          height: !model.terms
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 40),
                          context: context,
                          title: 'TERMS',
                          function: model.setTerms,
                          isSelected: model.terms,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.yMargin(context, 2),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Hotels NG (the “',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'Company',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            '”) operates a web/mobile application, “'),
                                    TextSpan(
                                        text: 'CustomerPayMe ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '” (the “'),
                                    TextSpan(
                                        text: 'App',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            '”) available on Google Play Store, iOS and other similar platforms also operates a website [App’s Website] (the “'),
                                    TextSpan(
                                        text: 'Website',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '”).')
                                  ])),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 2),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'By accessing our app, “',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'CustomerPayMe ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '” (the “'),
                                    TextSpan(
                                        text: 'App',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            '”), you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing '),
                                    TextSpan(
                                        text: 'CustomerPayMe',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '. The materials contained in '),
                                    TextSpan(
                                        text: 'CustomerPayMe',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            ' are protected by applicable copyright and trademark law.')
                                  ])),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'USE LICENSE',
                          function: model.setLicense,
                          isSelected: model.license,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.yMargin(context, 2),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text:
                                          'Permission is granted to temporarily download one copy of ',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'CustomerPayMe',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            ' per device for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:'),
                                  ])),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 2),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '-      Modify or copy the materials;                                ',
                                  style: TextStyle(
                                      color: Theme.of(context).cursorColor),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 1),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '-      Use the materials for any commercial purpose, or for any public display (commercial or non-commercial);',
                                  style: TextStyle(
                                      color: Theme.of(context).cursorColor),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 1),
                              ),
                              RichText(
                                text: TextSpan(
                                    text:
                                        '-      Attempt to decompile or reverse engineer any software contained in ',
                                    style: TextStyle(
                                        color: Theme.of(context).cursorColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'CustomerPayMe',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: '.'),
                                    ]),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 1),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '-       Remove any copyright or other proprietary notations from the materials; or',
                                  style: TextStyle(
                                      color: Theme.of(context).cursorColor),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 1),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '-      Transfer the materials to another person or "mirror" the materials on any other server.',
                                  style: TextStyle(
                                      color: Theme.of(context).cursorColor),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.yMargin(context, 2),
                              ),
                              RichText(
                                text: TextSpan(
                                    text:
                                        'This license shall automatically be terminated if you violate any of these restrictions and may be terminated by ',
                                    style: TextStyle(
                                        color: Theme.of(context).cursorColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Hotels NG',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              ' at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession whether in electronic or printed format.')
                                    ]),
                              ),
                            ],
                          ),
                          height: !model.license
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 62),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'DISCLAIMER',
                          function: model.setDisclaimer,
                          isSelected: model.disclaimer,
                          child:  Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'The materials within ',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' are provided on an "as is" basis. '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.'),
                                      ]),
                                ),
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Further, ',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its website or otherwise relating to such materials or on any sites linked to '),
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            ),
                          
                          height: !model.disclaimer
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 37),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'LIMITATIONS',
                          function: model.setLimitations,
                          isSelected: model.limitations,
                          child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'In no event shall ',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use '),
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: ', even if '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: ' or a '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.'),
                                      ]),
                                ),
                              ],
                            ),
                          height: !model.limitations
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 33),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'ACCURACY OF MATERIALS',
                          function: model.setAccuracy,
                          isSelected: model.accuracy,
                          child:  Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'The materials appearing in ',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' could include technical, typographical, or photographic errors. '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' does not warrant that any of the materials on '),
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' are accurate, complete or current. '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' may make changes to the materials contained in '),
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' at any time without notice. However, '),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' does not make any commitment to update the materials.'),
                                      ]),
                                ),
                              ],
                            ),
                        
                          height: !model.accuracy
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 25.5),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'LINKS',
                          function: model.setLinks,
                          isSelected: model.links,
                          child:  Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Hotels NG',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' has not reviewed all of the sites linked to its app and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                        TextSpan(
                                            text: 'Hotels NG',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        TextSpan(
                                            text:
                                                ' of the site. Use of any such linked website is at the user\'s own risk.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ]),
                                ),
                              ],
                            ),
                          
                          height: !model.links
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 22),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'MODIFICATIONS',
                          function: model.setModifications,
                          isSelected: model.modifications,
                          child:  Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Hotels NG',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).cursorColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' may revise these terms of service for its app at any time without notice. By using ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                        TextSpan(
                                            text: 'CustomerPayMe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                ' you are agreeing to be bound by the then current version of these terms of service.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ]),
                                ),
                              ],
                            ),
                          
                          height: !model.modifications
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 18),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                        container(
                          context: context,
                          title: 'GOVERNING LAW',
                          function: model.setLaw,
                          isSelected: model.law,
                          child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.yMargin(context, 2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'These terms and conditions are governed by and construed in accordance with the laws of Nigeria and you irrevocably submit to the exclusive jurisdiction of the courts in that State or location.',
                                      style: TextStyle(
                                          color: Theme.of(context).cursorColor),))
                              ],
                            ),
                          
                          height: !model.law
                              ? SizeConfig.yMargin(context, 8.5)
                              : SizeConfig.yMargin(context, 18),
                        ),
                        SizedBox(
                          height: SizeConfig.yMargin(context, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => TermsAndConditionViewModel(),
    );
  }

  Container container(
      {Widget child,
      String title,
      bool isSelected,
      Function function,
      double height,
      double width,
      BuildContext context}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2)),
      child: InkWell(
          onTap: function,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.xMargin(context, 5),
                vertical: SizeConfig.yMargin(context, 2)),
            decoration: BoxDecoration(
              color: ThemeColors.background,
              borderRadius:
                  BorderRadius.circular(SizeConfig.yMargin(context, 2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    isSelected
                        ? Icon(
                            Icons.keyboard_arrow_up,
                            color: BrandColors.primary,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down,
                            color: BrandColors.primary,
                          )
                  ],
                ),
                isSelected ? child : Container(),
              ],
            ),
          )),
    );
  }
}
