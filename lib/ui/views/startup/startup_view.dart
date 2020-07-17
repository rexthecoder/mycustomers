import 'package:flutter/material.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<StartupViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            Container(
                height: height * 2,
                width: width * 2,
                color: Colors.black12.withOpacity(0.9),
                child: Opacity(
                  opacity: 0.1,
                  child: Container(
                    margin: EdgeInsets.only(left: 65),
                    child: Image.asset('assets/images/startup_bg.png'),
                  ),
                )),
            Center(
              child: LoadingAnimation(),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.setup(),
    );
  }
}
