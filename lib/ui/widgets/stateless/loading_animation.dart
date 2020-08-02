import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/constants/animations.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

// ignore: must_be_immutable
class LoadingAnimation extends StatelessWidget {
  double height = 30;

  LoadingAnimation({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.yMargin(context, height),
      child: FlareActor(
        Animations.loader,
        animation: Animations.loader_name,
      ),
    );
  }
}
