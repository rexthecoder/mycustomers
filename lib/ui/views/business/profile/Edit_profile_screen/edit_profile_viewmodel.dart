import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends BaseViewModel{
  File _imgFile;
  final _imagePicker=ImagePicker();
  // File get image => _imgFile;

  String _pageTitle='Edit Profile';
  String get pageTitle => _pageTitle;

  String _profilePicBtn = 'Add a Profile Picture';
  String get profilePicBtn => _profilePicBtn;

  String _mainBtnText = 'Save';
  String get mainBtnText => _mainBtnText;

   Future getImagefromcamera() async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.camera);
    _imgFile=File(pickedImage.path);
    notifyListeners();
   }

   Future getImagefromGallery() async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
   _imgFile = File(pickedImage.path);
   notifyListeners();
   }

   Widget addImage(BuildContext context){
    return _imgFile == null ? Text('C',
                  style: TextStyle(
                      color:BrandColors.primary,
                      fontSize: SizeConfig.textSize(context,18)
                    ),
                  ): Image.file(_imgFile);
   }
   
}