import 'package:stacked/stacked.dart';

class EditProfileViewModel extends BaseViewModel{

  String _pageTitle='Edit Profile';
  String get pageTitle => _pageTitle;

  String _profilePicBtn = 'Add a Profile Picture';
  String get profilePicBtn => _profilePicBtn;

  String _mainBtnText = 'Save';
  String get mainBtnText => _mainBtnText;
}