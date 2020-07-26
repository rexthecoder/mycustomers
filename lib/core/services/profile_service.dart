import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/user_profile/profile_h.dart';

class ProfileService {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.profile);
  Box<Profile> get _profileBox => _hiveService.box<Profile>(HiveBox.profile);

  List<Profile> profiles = [];

  Future<void> init() async {
    _hiveService.registerAdapter(ProfileAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<Profile>(HiveBox.profile);
    }
  }

  Profile getProfile(String id){
    //Profile profile;
    for(var item in _profileBox.values.toList()) {
      if(item.sId == id) {
        return item;
      }
    }
    return _profileBox.values.toList()[0];
  }

  void addProfile(Profile profile)async{
    await _profileBox.add(profile);
  }

  void updateProfile(Profile profile) async {
    await _profileBox.putAt(0, profile);
  }
}