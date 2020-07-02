import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/profile/main_screen/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainProfilePageView extends StatelessWidget{
  TextEditingController _userName = TextEditingController(text : 'Casper');
  TextEditingController _businessName = TextEditingController(text : 'WearSmute');
  @override
  Widget build(BuildContext context){

    return ViewModelBuilder<MainProfilePageViewModel>.reactive(
      builder: (context,model,child )=> Scaffold(
        appBar: AppBar(
          title:Text(model.title,
          style: kheadingText, 
          ),
          centerTitle: true,
          elevation:0.0,
          iconTheme: IconThemeData(
            color:BrandColors.primary
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                model.navigateToEditProfilePage();
              }, 
              child: Text(model.btnText,
              style: TextStyle(
                fontSize:SizeConfig.textSize(context,4),
                color: BrandColors.primary
              ),
              ))
          ],
        ),
        body:SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:<Widget>[ 
                   Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                      backgroundColor: ThemeColors.unselect,
                      radius: 70,
                      child:Text('C',
                      style: TextStyle(
                        color:BrandColors.primary,
                        fontSize: SizeConfig.textSize(context,18)
                      ),
                      )
                    ),
                  ),
              
              Divider(
                color:ThemeColors.gray.shade600
              ),
              Expanded(
                  child: Container(
                  padding: EdgeInsets.only(left:SizeConfig.yMargin(context, 4) ),
                  child:Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                        children: <Widget>[
                          Text(model.nameLabel),
                          SizedBox(width: 30),
                          Expanded(
                              child: TextField(
                              autofocus: false,
                              controller: _userName,
                              textAlign: TextAlign.left,
                              onChanged: model.updateUserName,
                              readOnly: true,
                              decoration:InputDecoration(
                                border:UnderlineInputBorder()),
                              style: TextStyle(
                                color:ThemeColors.black ),
                            ),
                          )
                        ],),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                        children: <Widget>[
                          Text(model.businessNameLabel),
                          SizedBox(width: 18),
                          Expanded(
                              child: TextField(
                              autofocus: false,
                              controller: _businessName,
                              textAlign: TextAlign.left,
                              onChanged: model.updateBusinessName,
                              readOnly: true,
                              decoration: InputDecoration(
                                border:UnderlineInputBorder()
                              ),
                            ),
                          )

                        ],),
                      )
                    ],)
                ),
              )

            ]
          )
            )
      ), 

      viewModelBuilder:() =>MainProfilePageViewModel());
  }

}