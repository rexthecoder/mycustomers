import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:stacked/stacked.dart';
import 'addAssistant_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';


class AddAssistantView extends StatelessWidget {
  TextEditingController assistantNameController = new TextEditingController();
  TextEditingController inputNumberController = new TextEditingController();
  TextEditingController assistantRoleController = new TextEditingController();

    final _formKey = GlobalKey<FormState>();
    static final _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAssistantViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key:_key ,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: ThemeColors.background,
          centerTitle: true,
          title: Text(model.title,
          style: kheadingText),
          iconTheme: IconThemeData(
            color: BrandColors.secondary
          ),
          leading: IconButton(
            icon:Icon(Icons.arrow_back) , 
            onPressed: (){model.navigateBack();}),

        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Text(model.subTitle,
                    textAlign: TextAlign.justify,
                    style:model.textStyle),
                    SizedBox(height:32.0),  
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            //TODO Implement Routing to the add customer from contact list
                          },
                          child:CircleAvatar(
                            backgroundColor: Color(0xffD4D6F0),
                            child: Icon(
                              Icons.person_add,
                              color: BrandColors.secondary,
                              )
                          )
                        ),
                        SizedBox(width:14.0),
                        Text(model.frmContact,
                        style:TextStyle(
                          color:ThemeColors.black,
                          fontSize:18.sp,
                          letterSpacing: -0.02
                        ) ,)

                    ],),
                    SizedBox(height:30.0),
                    Text(model.addManually,
                    style: model.textStyle,),
                    Expanded(
                       child: Container(
                         height:227.h,
                         margin: EdgeInsets.only(top:8.0),
                        decoration: BoxDecoration(
                           color: Color.fromRGBO(196, 196, 196, 0.05),
                           border:Border.all(
                             color: Color.fromRGBO(196, 196, 196, 0.05),
                             width: 0.5
                             
                           ),
                           borderRadius: BorderRadius.circular(11.0)
                         ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Form(
                              key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child: TextFormField(
                                      validator:(value)=> model.validateFields(value),
                                      controller:assistantNameController,
                                      keyboardType: TextInputType.text,
                                      decoration:InputDecoration(
                                        hintText: 'Enter Name',
                                        hintStyle: model.hinttextStyle,
                                        labelText: model.nameLabel,
                                        labelStyle: model.formTextStyle,
                                        border:OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        contentPadding: EdgeInsets.all(14.0)
                                      ),
                                      
                                    ),
                                  ),
                                  SizedBox(height:20),

                                  Expanded(
                                      child: TextFormField(
                                      validator:(value)=>model.validateFields(value),
                                      controller: assistantRoleController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintText:'Enter Role',
                                        hintStyle: model.hinttextStyle,
                                        labelText: model.roleLabel,
                                        labelStyle: model.formTextStyle,
                                        border:OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        contentPadding: EdgeInsets.all(14.0)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:20),

                                  Expanded(
                                      child: TextFormField(
                                      validator:(value)=>model.validateFields(value),
                                      controller:inputNumberController,
                                      keyboardType:TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText:'Enter Phone Number',
                                        hintStyle: model.hinttextStyle,
                                        labelText: model.phoneNumberLabel,
                                        labelStyle: model.formTextStyle,
                                        border:OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        contentPadding: EdgeInsets.all(14.0)
                                      ),
                                    ),
                                  )
                                 

                                ],),
                            ),
                          ),),
                    ),
                    Spacer(),
                     Container(
                        height: 65.h,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom:15.0),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(5.0),
                          color: BrandColors.secondary
                          
                        ),
                        child:FlatButton(
                          onPressed:(){
                            //TODO Implement the action to be completed once the user clicks the save button
                          } ,
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style:TextStyle(
                              color:ThemeColors.background,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )
                          )) ,),
                  ]
                ),
            )
            
      ),
      ),
      viewModelBuilder: () => AddAssistantViewModel(),
    );
  }
}
