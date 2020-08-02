import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';

class AboutMyCustomerViewModel extends BaseViewModel {
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

  static List<Person> aboutCustomerPay = [
    Person(
      about:
          "Title: myCustomer \nShort Desc: \nDebt Collection, Invoice Reminders, Sales Messaging\n\nLong Desc:\nmyCustomer is an on-demand solution that allows small business owners to keep a digital ledger of their business, keep track of debt and receive payments digitally.Best and FREE to manage all your debts and creditors. Add your Customers, Record Transactions, and Send Payment Reminders.myCustomer the new way to manage your ledger account book is here. Replace your old register with the new myCustomer App and never forget any entry. Manage your customers digitally with this easy to use mobile application.\n\nApp Features:\n❖	Easy to use - Simple and intuitive user interface for easy navigations.\n❖	100% Free - No Monthly Fees, No one-time cost. It's completely free to use.\n❖	Safe, Secure, Reliable - Only you have access to your data and no one else. You can lock your app with a code only you know.\n❖	Automatic and Secure Online Backup - myCustomer data is always available to you just a few taps away. Even if you lose your phone, just login with a verified phone number in a new phone to get the same data and settings.\n❖	Send WhatsApp payment reminders to your customers - Send WhatsApp or SMS payment reminders to your customers and manage all easily.\n❖	Manage multiple shops within one app.\n❖	Download your Customers PDF Report.\n❖	Free SMS updates to your customers on every transaction.\n❖	Full of Features - The App is regularly updated to give you the best features and experience. Best debit credit app.\n❖	Go Digital - Replace pen, paper and calculator with myCustomer ledger account book App.\n❖	Grow Business - Go Digital, Grow your business & Go smarter with myCustomer App.",
    )
  ];

  static List<Person> investors = [
    Person(
      about: '',
      imageUrl: 'assets/images/about_us/investors/Immachukwu.png',
      name: 'Esther Jolugba Aka Immachukwu',
    ),
    Person(
      about: '',
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
      about: 'UI/UX Designer',
      imageUrl: 'assets/images/about_us/design/Emaliasia.png',
      name: 'Agbodoroba Owhe Ogheneteriji Aka Emaliasia',
    ),
    Person(
      about: 'UI/UX Designer',
      imageUrl: 'assets/images/about_us/design/Smute.png',
      name: 'Akinnibosun Segun AKA Smute',
    ),
    Person(
      about: 'UI/UX DesignerUI/UX Designer',
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
      about: 'Lead Frontend Engineer',
      imageUrl: 'assets/images/about_us/web/kadet.jpeg',
      name: 'Collins Enebeli [Kadet]',
    ),
    Person(
      about: 'Backend Engineer <Tester and Manager>',
      imageUrl: 'assets/images/about_us/web/naza.jpg',
      name: 'Chinaza Obiekwe [Naza]',
    ),
    Person(
      about: 'Lead Backend Architect and Engineer',
      imageUrl: 'assets/images/about_us/web/mikah.jpg',
      name: 'Micah Elijah [CODEMIKAH]',
    ),
//    Person(
//      about: 'Backend Engineer',
//      imageUrl: 'assets/images/about_us/web/arturo.png',
//      name: 'Arturo Delgado [@ajdelgados]',
//    ),
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

  void increment() {
    print('designers ${currentAboutCustomerPayMe % designers.length}');
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
