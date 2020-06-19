import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String _firstName;
  final String _lastName;
  final double _amount;

  CustomerCard(this._firstName, this._lastName, this._amount);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height < 400
          ? 0.25 * deviceSize.height
          : 0.13 * deviceSize.height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.lightBlue[300],
                      ),
                      child: Center(
                        child: Text(
                          '${_firstName.substring(0, 1)}${_lastName.substring(0, 1)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$_firstName $_lastName',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Tap to pay in 4 days'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Text(
                '\$$_amount',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
