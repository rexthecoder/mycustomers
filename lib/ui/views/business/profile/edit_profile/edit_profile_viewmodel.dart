import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends BaseViewModel {
  final StoresLocalDataSource _ss = locator<StoresLocalDataSource>();
  final _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  bool _editing = false;
  bool get editing => _editing;

  Future<void> switchEditingState() async {
    if (_editing) {
      await _authService.updateCurrentUser(User(
        firstName: (_userName?.isNotEmpty ?? false)
            ? _userName
            : currentUser.firstName,
      ));
    }
    _editing = !_editing;
    notifyListeners();
  }

  final _imagePicker = ImagePicker();
  String pNum,
      address,
      tagline,
      email,
      _userName,
      _businessName,
      _retrieveDataError;

  Store get currentStore => StoreRepository.currentStore;
  User get currentUser => _authService.currentUser;
  String get retrieveDataError => _retrieveDataError;
  String get userName => _userName;
  String get businessName => _businessName;

  set retrieveDataError(value) {
    _retrieveDataError = value;
  }

  Future getImagefromcamera(String value) async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.camera);
    await updateImage(pickedImage);
//    _imgFile =File(pickedImage.path);
    notifyListeners();
  }

  void getImagefromGallery() async {
    final pickedImage =
        await _imagePicker.getImage(source: ImageSource.gallery);
    await updateImage(pickedImage);
//    _imgFile = File(pickedImage.path);
//    sImage = base64String(_imgFile.readAsBytesSync());
//    print(sImage);
    notifyListeners();
  }

  Future<void> updateImage(PickedFile pickedImage) async {
    if (pickedImage != null) {
      var imgToUint = await pickedImage.readAsBytes();
      _ss.updateStore(currentStore.id, currentStore..storePic = imgToUint);
      StoreRepository.updateStores();
    }
  }

  void handleLostData(PickedFile file) {}

  void updateUserName(String value) {
    _userName = value;
  }

  void updateBusinessName(String value) {
    _businessName = value;
  }

  void updateEmail(String value) {
    email = value;
  }

  void updateAddress(String value) {
    address = value;
  }

  void updatePNum(String value) {
    pNum = value;
  }

  void updateTagline(String value) {
    tagline = value;
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response == null || (response?.isEmpty ?? true)) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) await updateImage(response.file);
      notifyListeners();
    }
//    } else {
//      _retrieveDataError = response.exception.code;
//      return _retrieveDataError;
//    }
  }

  Future<void> save() async {
      await _ss.updateStore(
        currentStore.id,
        currentStore
          ..name = (_businessName?.isNotEmpty ?? false)
              ? _businessName
              : currentStore.name
          ..address = (address?.isNotEmpty ?? false)
              ? address
              : currentStore.address
          ..tagline = (tagline?.isNotEmpty ?? false)
              ? tagline
              : currentStore.tagline,
      );
      await StoreRepository.updateStores();
      print(currentStore.name);
      await _authService.updateCurrentUser(User(
//        firstName: (_userName?.isNotEmpty ?? false)
//            ? _userName
//            : currentUser.firstName,
        email: (email?.isNotEmpty ?? false)
            ? email
            : currentUser.email,
        phoneNumber: (pNum?.isNotEmpty ?? false)
            ? pNum
            : currentUser.phoneNumber,
      ));
      _navigationService.back();
  }

  Future showConfirmationDialog() async {
    var response = await _dialogService.showConfirmationDialog(
      title: 'Confirmation Dialog',
      description: 'Do you want to sign out?',
      confirmationTitle: 'Sign out',
      cancelTitle: 'Cancel',
    );

    if (response.confirmed) {
      await _authService.signOut();
    }
    notifyListeners();
  }
}
