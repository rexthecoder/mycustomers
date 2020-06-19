import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  CustomRaisedButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      color: Color(0xFF333CC1),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Image.asset('assets/images/arrow_forward.png'),
        ],
      ),
    );
  }
}
