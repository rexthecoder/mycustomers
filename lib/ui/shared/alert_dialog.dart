
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

Future<void> showConfirmationMessage(BuildContext context) async {
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return InkWell(
          onTap: null,
          child: SimpleDialog(
          children: <Widget>[
            Center(
              child: Column(
                children:<Widget>[
                  CircleAvatar(
                    backgroundColor: BrandColors.primary,
                    child: Icon(Icons.check,
                    color:ThemeColors.background),
                  ),
                  Text('Saved')
                ]
              ),
            ),
            
          ],
        ),
      );
    }
  );
}


