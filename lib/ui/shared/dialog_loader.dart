import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

Widget buildLoaderDialog(BuildContext context, DialogRequest request) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              request.title != null
                  ? Text(
                    request.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )
                  : Container(),
              SizedBox(height: 20,),
              Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
