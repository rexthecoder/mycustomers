import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class SlideMenu extends StatefulWidget {
  final bool isCollapsed;

  const SlideMenu({Key key, this.isCollapsed}) : super(key: key);

  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double x = 0;

  double right;
  double left;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),

    )..addListener(() {
        setState(() {
          x = _controller.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      right: widget.isCollapsed ? SizeConfig.xMargin(context, 100) : 0,
      top: 0,
      bottom: 0,
      left: widget.isCollapsed ? SizeConfig.xMargin(context, -100) : 0,
      child: GestureDetector(
        child: Scaffold(),
        onHorizontalDragUpdate: (details) {
          _controller.value = x + details.delta.dx;
        },
        onHorizontalDragEnd: (details) {
//          var width = SizeConfig.xMargin(context, 100) * -1;
//
//          var newScrollOffset;
//
//          num n = x / width;
//
//          if (details.primaryVelocity < 100) {
//            newScrollOffset = n.ceil() * width;
//          } else if (details.primaryVelocity > -100) {
//            newScrollOffset = n.floor() * width;
//          } else {
//            newScrollOffset = n.round() * width;
//          }
//
//          _controller.animateTo(
//            newScrollOffset,
//            duration: const Duration(milliseconds: 150),
//          );
        },
      ),
      duration: new Duration(milliseconds: 300),
    );
  }
}
