import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final Function onTap;
  final socialIconUrl;

  SocialIconButton({
    @required this.onTap,
    @required this.socialIconUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Image.asset(
            socialIconUrl,
            width: 16,
            height: 16,
          ),
        ),
      ),
    );
  }
}
