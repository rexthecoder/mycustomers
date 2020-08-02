import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';

class AboutMyCustomerViewModel extends BaseViewModel {
  String text = '';
  bool isOpenAboutCustomerPayMe = false;
  bool isOpenMeetTheInvestors = false;
  bool isOpenMeetTheDesigners = false;
  bool isOpenMeetTheMobileTeam = false;
  bool isOpenMeetTheWebTeam = false;

//  List<List<Person>> investorsMap = [
//    [investors[0]],
//    [
//      investors[1],
//      investors[2],
//    ],
//    [investors[3]],
//    [
//      investors[4],
//      investors[5],
//    ],
//    [investors[6]]
//  ];
//  List<List<Person>> mobileMap = [
//    [mobile[0]],
//    [
//      mobile[1],
//      mobile[2],
//    ],
//    [mobile[3]],
//    [
//      mobile[4],
//      mobile[5],
//    ],
//    [mobile[6]]
//  ];
//  List<List<Person>> webMap = [
//    [web[0]],
//    [
//      web[1],
//      web[2],
//    ],
//    [web[3]],
//    [
//      web[4],
//      web[5],
//    ],
//    [web[6]]
//  ];

  static List<Person> investors = [
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/about_us/investors/Immachukwu.png',
      name: 'Esther Jolugba Aka Immachukwu',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/about_us/investors/PepJeo.png',
      name: 'Joseph Etim Aka PepJeo',
    ),
    Person(
      about: 'Product Manager',
      imageUrl: 'assets/images/about_us/investors/Tochi.png',
      name: 'Tochi',
    ),
    Person(
      about: 'CEO - Hotels.ng',
      imageUrl: 'assets/images/about_us/investors/Mark.png',
      name: 'Mark Essien',
    ),
    Person(
      about: 'Co-Founder',
      imageUrl: 'assets/images/about_us/investors/xyluz.jpeg',
      name: 'Seyi Onifade Aka xyluz',
    ),
  ];
  static List<Person> designers = [
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/about_us/design/Emaliasia.png',
      name: 'Agbodoroba Owhe Ogheneteriji Aka Emaliasia',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/about_us/design/Smute.png',
      name: 'Akinnibosun Segun AKA Smute',
    ),
    Person(
      about:
          'About MeLorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/about_us/design/Zurikus.png',
      name: 'Victor Onwuzuruike AKA Zurikus',
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
  int currentMeetTheInvestors = 0;
  int currentMeetTheMobileTeam = 0;
  int currentMeetTheDesignTeam = 0;
  int currentMeetTheWebTeam = 0;

  void changeOpenMeetTheMobileTeam() {
    isOpenMeetTheMobileTeam = !isOpenMeetTheMobileTeam;
    notifyListeners();
  }

  void changeOpenAboutCustomerPayMe() {
    isOpenAboutCustomerPayMe = !isOpenAboutCustomerPayMe;
    notifyListeners();
  }

  void changeOpenMeetTheInvestors() {
    isOpenMeetTheInvestors = !isOpenMeetTheInvestors;
    notifyListeners();
  }

  void changeOpenMeetTheDesigner() {
    isOpenMeetTheDesigners = !isOpenMeetTheDesigners;
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
    currentMeetTheInvestors++;
    currentMeetTheMobileTeam++;
    currentMeetTheDesignTeam++;
    currentMeetTheWebTeam++;
    notifyListeners();
  }
}

class Person {
  final String name;
  final String about;
  final String imageUrl;

  Person({this.name, this.about, this.imageUrl});
}
