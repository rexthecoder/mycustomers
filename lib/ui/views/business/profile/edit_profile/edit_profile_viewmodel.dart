import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';

class EditProfileViewModel extends BaseViewModel {
  final _storeRepository = locator<StoreRepository>();
  final _authService = locator<AuthService>();

  File _imgFile;
  final _imagePicker = ImagePicker();
  String _userName;

  String _retrieveDataError;

  String get retrieveDataError => _retrieveDataError;

  String get userName => _userName;
  String _businessName;

  String get businessName => _businessName;

  File get image => _imgFile;

  set retrieveDataError(value) {
    _retrieveDataError = value;
  }

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

  void updateUserName(String value) {
    _userName = value;
    notifyListeners();
  }

  void updateBusinessName(String value) {
    _businessName = value;
    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _imgFile = File(response.file.path);
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  init() {
    _userName = _authService?.currentUser?.firstName ?? 'None';
    _businessName = _storeRepository?.currentStore?.name ?? 'None';
    notifyListeners();
  }



  void updateProfile() {
    // TODO UPDATE PROFILE
  }
}
