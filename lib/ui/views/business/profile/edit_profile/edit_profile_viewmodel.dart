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

  final _imagePicker = ImagePicker();
  String _userName;
  String email;

  Store get currentStore => StoreRepository.currentStore;
  User get currentUser => _authService.currentUser;

  String _retrieveDataError;

  String get retrieveDataError => _retrieveDataError;

  String get userName => _userName;
  String _businessName;

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
    final pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
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

  void handleLostData(PickedFile file) {

  }

  void updateUserName(String value) {
    _userName = value;
    print('ttty');
    notifyListeners();
  }

  void updateBusinessName(String value) {
    _businessName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response == null || (response?.isEmpty ?? true)) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image)
      await updateImage(response.file);
      notifyListeners();
    }
//    } else {
//      _retrieveDataError = response.exception.code;
//      return _retrieveDataError;
//    }
  }

  void save() {
    if(_userName != null || _businessName != null) {
      _ss.updateStore(currentStore.id, currentStore..name = (_businessName?.isNotEmpty ?? false) ? _businessName : currentStore.name);
      _authService.updateCurrentUser(User(firstName: _userName));
      _navigationService.back();
    } else {
      _navigationService.back();
    }
  }

  initt() {
    if (_userName == null)
    _userName = _authService?.currentUser?.firstName ?? 'None';
    if (_businessName == null)
    _businessName = StoreRepository?.currentStore?.name ?? 'None';
    notifyListeners();
  }

}
