import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class CustomShareRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final String share = 'assets/icons/svg/share.svg';

  CustomShareRaisedButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.yMargin(context, 3),
      ),
      child: RaisedButton(
        onPressed: onPressed,
        color: BrandColors.primary,
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              share,
              color: ThemeColors.background,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: SizeConfig.textSize(context, 5),
                color: ThemeColors.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
