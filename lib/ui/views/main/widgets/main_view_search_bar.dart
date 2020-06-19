part of '../main_view.dart';

///Created by Demilade Oladugba on 6/19/2020

class MainViewSearchBar extends StatelessWidget {
  const MainViewSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xE8E8E8FF)),
        color: const Color(0xF6F6F6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset(search),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
