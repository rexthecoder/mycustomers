import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends BaseViewModel {
  File _imgFile;
  final _imagePicker = ImagePicker();

   File get image => _imgFile;

  Future getImagefromcamera() async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.camera);
    _imgFile = File(pickedImage.path);
    notifyListeners();
  }

  Future getImagefromGallery() async {
    final pickedImage =
        await _imagePicker.getImage(source: ImageSource.gallery);
    _imgFile = File(pickedImage.path);
    notifyListeners();
  }
}
