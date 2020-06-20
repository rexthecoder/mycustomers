part of '../../views/main/main_view.dart';

///Created by Demilade Oladugba on 6/19/2020

AppBar mainViewAppBar(MainViewModel model) {
  return AppBar(
    backgroundColor: const Color(0xFCFCFCFF),
    title: Text(
      model.currentUsername.capitalize ?? "",
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: false,
    elevation: 0,
    actions: [
      FlatButton(
        onPressed: () {},
        child: SvgPicture.asset(
          notification,
          semanticsLabel: 'notification',
        ),
      )
    ],
  );
}
