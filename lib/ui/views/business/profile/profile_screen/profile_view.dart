import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/profile/profile_screen/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _userName = TextEditingController(text: 'Casper');
    TextEditingController _businessName =
        TextEditingController(text: 'WearSmute');

    return ViewModelBuilder<MainProfilePageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: ThemeColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textSize(context, 6),
                  ),
                ),
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: BrandColors.primary),
                actions: <Widget>[
                  FlatButton(
                    onPressed: model.navigateToEditProfilePage,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 4.4),
                        color: BrandColors.primary,
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.yMargin(context, 2),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: ThemeColors.unselect,
                          radius: SizeConfig.yMargin(context, 12),
                          child: Text(
                            'C',
                            style: TextStyle(
                              color: BrandColors.primary,
                              fontSize: SizeConfig.textSize(context, 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: ThemeColors.gray.shade600),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.yMargin(context, 4),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Name'),
                                  SizedBox(width: 30),
                                  Expanded(
                                    child: TextField(
                                      autofocus: false,
                                      controller: _userName,
                                      textAlign: TextAlign.left,
                                      onChanged: model.updateUserName,
                                      decoration: InputDecoration(
                                        enabled: false,
                                        border: UnderlineInputBorder(),
                                      ),
                                      style:
                                          TextStyle(color: ThemeColors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Business\nName'),
                                  SizedBox(width: 18),
                                  Expanded(
                                    child: TextField(
                                      autofocus: false,
                                      controller: _businessName,
                                      textAlign: TextAlign.left,
                                      onChanged: model.updateBusinessName,
                                      decoration: InputDecoration(
                                        enabled: false,
                                        border: UnderlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => MainProfilePageViewModel());
  }
}
