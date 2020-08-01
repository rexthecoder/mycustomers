import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';

import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StatelessWidget {
  final String myCustomerLogo = 'assets/icons/svg/customerpaymelogo.svg';
  @override
  Widget build(BuildContext context) {
//    return ViewModelBuilder<PrivacyPolicyViewModel>.reactive(
//      builder: (context, model, child) => Scaffold(
//        appBar: customizeAppBar(
//          context,
//          1.0,
//          title: 'Privacy Policy',
//          arrowColor: BrandColors.primary,
//          backgroundColor: Theme.of(context).backgroundColor,
//        ),
//        backgroundColor: Theme.of(context).backgroundColor,
//        body: Container(
//          child: UnderConstruction(),
//        ),
//      ),
//      viewModelBuilder: () => PrivacyPolicyViewModel(),
////      onModelReady: (model) => model.openDoc(),
//    );
    return ViewModelBuilder<PrivacyPolicyViewModel>.reactive(
      onModelReady: (model) {
        model.delay();
      },
      builder: (context, model, child) => Scaffold(
//        appBar: customizeAppBar(
//          context,
//          1.0,
//          title: 'Privacy Policy',
//          arrowColor: BrandColors.primary,
//          backgroundColor: Theme.of(context).backgroundColor,
//        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child:  model.checkbusy == true
              ? Center(child: LoadingAnimation())
              : Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            myCustomerLogo,
    //                  color: ThemeColors.background,
                            height: SizeConfig.xMargin(context, 20),
                            width: SizeConfig.xMargin(context, 20),
                          ),
                          SizedBox(
                            width: SizeConfig.xMargin(context, 5),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Privacy Policy',
                                style: TextStyle(
                                  color: BrandColors.primary,
                                  fontSize: SizeConfig.textSize(context, 6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Updated 31/07/2020',
                                style: TextStyle(
                                  color: ThemeColors.gray[800],
                                  fontSize: SizeConfig.textSize(context, 3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 5),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Theme.of(context).cursorColor,
                                fontSize: SizeConfig.textSize(context, 3.8),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Hotels NG',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:' built the '),
                                TextSpan(
                                    text: 'CustomerPayMe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' app as a Free app. This SERVICE is provided by '),
                                TextSpan(
                                    text: 'Hotels NG',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' at no cost and is intended for use as is.\n \n '),

                              ])),
                      Text(
                         'This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\n \n'
                          'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),
                      RichText(
                          text: TextSpan(
                              text: 'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at ',
                              style: TextStyle(
                                color: Theme.of(context).cursorColor,
                                fontSize: SizeConfig.textSize(context, 3.8),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'CustomerPayMe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:' unless otherwise defined in this Privacy Policy.\n \n'),


                              ])),


                      ///INFORMATION COLLECTION AND USE
                      Text(
                         'INFORMATION COLLECTION AND USE \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text(
                          'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to N/A. The information that we request will be retained by us and used as described in this privacy policy.\n \n'
                          'The app does use third party services that may collect information used to identify you.\n \n'
                      'Link to privacy policy of third-party service providers used by the app \n \n'
                      '[Google Play Services] (https://www.google.com/policies/privacy/) \n \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),

                      ///LOG DATA
                      Text(
                          'LOG DATA \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text(
                          'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics. \n \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),


                      ///COOKIES
                      Text(
                          'COOKIES \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\n \n'
                          'This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n \n'
                          ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),


                      ///SERVICE PROVIDERS
                      Text(
                          'SERVICE PROVIDERS \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      RichText(
                          text: TextSpan(
                              text: 'We may employ third-party companies and individuals due to the following reasons:\n \n',
                              style: TextStyle(
                                color: Theme.of(context).cursorColor,
                                fontSize: SizeConfig.textSize(context, 3.8),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.textSize(context, 4),
                                    )),
                                TextSpan(
                                    text:'   To facilitate our Service;\n'),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.textSize(context, 4),
                                    )),
                                TextSpan(
                                    text:'   To provide the Service on our behalf;\n'),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.textSize(context, 4),
                                    )),
                                TextSpan(
                                    text:'   To perform Service-related services; or\n'),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.textSize(context, 4),
                                    )),
                                TextSpan(
                                    text:'   To assist us in analyzing how our Service is used.\n'),


                              ])),

                      ///SECURITY
                      Text(
                          'SECURITY \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n \n'
                          ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),

                      ///LINKS TO OTHER SITES
                      Text(
                          'LINKS TO OTHER SITES \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n \n'
                          ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),


                      ///CHILDREN’S PRIVACY
                      Text(
                          'CHILDREN’S PRIVACY \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to carry out necessary actions.\n \n'
                      ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),

                      ///CHANGES TO THIS PRIVACY POLICY

                      Text(
                          'CHANGES TO THIS PRIVACY POLICY \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n \n \n'
                          'This policy is effective as of 2020-06-21\n \n'
                      ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),

                    ///CONTACT US
                      Text(
                          'CONTACT US \n',
                          style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textSize(context, 4.2),
                          )),
                      Text('We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n \n \n'
                          'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at [E-MAIL].\n \n'
                      ,style: TextStyle(
                            color: Theme.of(context).cursorColor,
                            fontSize: SizeConfig.textSize(context, 3.8),
                          )),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PrivacyPolicyViewModel(),
//      onModelReady: (model) => model.openDoc(),
    );
  }
}
