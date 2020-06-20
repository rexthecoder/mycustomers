import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycustomers/ui/views/home/home_view.dart';
import 'package:mycustomers/ui/views/marketing/marketing_view.dart';
import 'package:mycustomers/ui/views/profile/profile_view.dart';
import 'package:mycustomers/ui/widgets/animation/fade_in.dart';
import 'package:mycustomers/ui/widgets/stateful/lazy_index_stacked.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';


class MainView extends StatelessWidget {

 
  final _views = <Widget>[
    FadeIn(child: HomeView()),
    FadeIn(child: MarketingView()),
    FadeIn(child: ProfileView()),
  ];


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );


     return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => Scaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: model.index,
          itemCount: _views.length,
          itemBuilder: (_, index) => _views[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Marketing'),
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Your Company'),
            ),
          ],
          onTap: model.changeTab,
        ),
      ),
    );
  }
}
