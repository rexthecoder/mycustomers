import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

//import 'details_viewmodel.dart';

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        body: SafeArea(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: new Container(
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            iconSize: 40.0,
                            onPressed: (){},
                          ),
                          new Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: new Row(
                              children: <Widget>[
                                new CircleAvatar(
                                  /*child: model.customerPicture,*/     // I don't know if this will give error so it's commented
                                  radius: 40.0,
                                  backgroundColor: Colors.lightBlue[900],    // This will be removed when picture is ready
                                ),
                                new Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(model.customerName ,style: TextStyle(fontSize: 28.0,color: Colors.grey[900]),),
                                      new SizedBox(height: 3.0,),
                                      new Text(model.customerNumber ,style: TextStyle(fontSize: 20.0,color: Colors.grey[600]),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      new SizedBox(height: 10.0,),
                      new Divider()
                    ],
                  ),
                ),
              ),
              new Expanded(
                flex: 3,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        color: Colors.grey[100],
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              child: new Center(
                                child: new Column(
                                  children: <Widget>[
                                    new Icon(Icons.lock_outline, size: 50.0,color: Colors.lightBlue[900],),
                                    new SizedBox(height: 20.0,),
                                    new Text(
                                      'MyCustomers is 100% safe and secure, only \n you and customer can view this \n transaction.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      color: Colors.lightBlue[100],
                      height: 50.0,
                      child: new Center(
                        child: new Text(
                          'Add first transation of customer',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                                                                              // Collecting Button
                    new GestureDetector(
                      onTap: (){},
                      child: new Container(
                        height: 60.0,
                        width: 180.0,
                        decoration: new BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: new Center(
                          child: new Text(
                            'COLLECTING',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                                                                              // Giving Button
                    new GestureDetector(
                      onTap: (){},
                      child: new Container(
                        height: 60.0,
                        width: 180.0,
                        decoration: new BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: new Center(
                          child: new Text(
                            'GIVING',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => DetailsViewModel(),
    );
  }
}

class DetailsViewModel extends BaseViewModel {
  // Customer Name
  String _customerName = 'Seyi Onifade';
  String get customerName => _customerName;

  //Customer Number
  String _customerNumber = 09045678901.toString();
  String get customerNumber => _customerNumber;

  //Customer Picture, which is a color for now
  dynamic _customerPicture = Colors.lightBlue[900];
  dynamic get customerPicture => _customerPicture;

}