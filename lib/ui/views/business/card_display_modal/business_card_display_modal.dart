import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/card_display_modal/business_card_display_viewModel.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:stacked/stacked.dart';
// import 'package:mycustomers/ui/shared/widgets/business/business_card/business_card_widget.dart';




class BusinessCardDisplayModal extends StatelessWidget{

@override
Widget build(BuildContext context){
  return ViewModelBuilder<BusinessCardDisplayViewModel>.reactive(
    builder: (context,model,child)=>Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:ThemeColors.background
          )),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:SizeConfig.xMargin(context, 4)),
        child: Column(
          children:<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Business card'),
                FlatButton(
                  color: ThemeColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  onPressed: model.navigateToEditProfilePage, 
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 4.4),
                      color: BrandColors.primary
                    ),
                    ))
              ],),
              Text('The business Image should go here'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                CustomShareRaisedButton(
                  label: 'Share', 
                  onPressed: (){
                    model.shareImageAndText();
                  } ),
                  FlatButton(
                    color: BrandColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(32)
                    ),
                    onPressed: null, 
                    child: Text(
                      'Download',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: BrandColors.primary,
                        fontSize: SizeConfig.textSize(context, 4.4)
                        ),
                      )
                    )
                ],)
         ]
        ),
      ),
    ),
    viewModelBuilder:() =>BusinessCardDisplayViewModel(),
    onModelReady: (model)=>model.init(),
  );

}
  
}