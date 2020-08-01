import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';

class AboutMyCustomerViewModel extends BaseViewModel {
  String text = '';
  bool isOpenAboutCustomerPayMe = false;
  bool isOpenMeetTheLeaders = false;
  bool isOpenMeetTheMobileTeam = false;
  bool isOpenMeetTheWebTeam = false;

  List<List<Person>> leaderMap = [
    [leader[0]],
    [
      leader[1],
      leader[2],
    ],
    [leader[3]],
    [
      leader[4],
      leader[5],
    ],
    [leader[6]]
  ];
  List<List<Person>> mobileMap = [
    [mobile[0]],
    [
      mobile[1],
      mobile[2],
    ],
    [mobile[3]],
    [
      mobile[4],
      mobile[5],
    ],
    [mobile[6]]
  ];
  List<List<Person>> webMap = [
    [web[0]],
    [
      web[1],
      web[2],
    ],
    [web[3]],
    [
      web[4],
      web[5],
    ],
    [web[6]]
  ];

  static List<Person> leader = [
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
  ];
  static List<Person> mobile = [
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
  ];
  static List<Person> web = [
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: '',
      name: 'A name',
    ),
  ];

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

class Person {
  final String name;
  final String about;
  final String imageUrl;

  Person({this.name, this.about, this.imageUrl});
}
