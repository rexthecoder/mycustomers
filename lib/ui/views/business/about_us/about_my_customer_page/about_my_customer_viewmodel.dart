import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';

class AboutMyCustomerViewModel extends BaseViewModel {
  String text = '';
  bool isOpenAboutCustomerPayMe = false;
  bool isOpenMeetTheLeaders = false;
  bool isOpenMeetTheMobileTeam = false;
  bool isOpenMeetTheWebTeam = false;

  int currentAboutCustomerPayMe = 0;
  int currentMeetTheLeaders = 0;
  int currentMeetTheMobileTeam = 0;
  int currentMeetTheWebTeam = 0;

  void changeOpenMeetTheMobileTeam() {
    isOpenMeetTheMobileTeam = !isOpenMeetTheMobileTeam;
    notifyListeners();
  }

  void changeOpenAboutCustomerPayMe() {
    isOpenAboutCustomerPayMe = !isOpenAboutCustomerPayMe;
    notifyListeners();
  }

  void changeOpenMeetTheLeaders() {
    isOpenMeetTheLeaders = !isOpenMeetTheLeaders;
    notifyListeners();
  }

  void changeOpenMeetTheWebTeam() {
    isOpenMeetTheWebTeam = !isOpenMeetTheWebTeam;
    notifyListeners();
  }

  Future<void> openDoc() async {
    final result = await OpenFile.open("assets/files/App details.docx");
    text = result.message;
  }

  void increment() {
    currentAboutCustomerPayMe++;
    notifyListeners();
  }
}
