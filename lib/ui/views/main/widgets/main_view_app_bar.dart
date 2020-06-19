part of '../main_view.dart';

///Created by Demilade Oladugba on 6/19/2020

PlatformAppBar mainViewAppBar(MainViewModel model) {
  return PlatformAppBar(
    backgroundColor: const Color(0xFCFCFCFF),
    title: Text(
      model.currentUsername.capitalize ?? "",
      style: TextStyle(color: Colors.black),
    ),
    trailingActions: [
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
