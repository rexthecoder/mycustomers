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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
