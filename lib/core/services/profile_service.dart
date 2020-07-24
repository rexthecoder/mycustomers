import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/user_profile/profile_h.dart';

class ProfileService {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.profile);
  Box<Profile> get _profileBox => _hiveService.box<Profile>(HiveBox.profile);

  Future<void> init() async {
    _hiveService.registerAdapter(ProfileAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Profile>(HiveBox.profile);
    }
  }

  Profile getProfile(){
    return _profileBox.values.toList()[0];
  }

  void addProfile(Profile profile)async{
    await _profileBox.add(profile);
  }

  void updateProfile(Profile profile) async {
    await _profileBox.putAt(0, profile);
  }
}