import 'package:flutter/material.dart';

class BreakdownCard extends StatelessWidget {
  final double receivingAmount;
  final double payingAmount;
  final bool isPaying;
  final bool isReceiving;
  final Function onClick;

  BreakdownCard({
    this.payingAmount,
    @required this.onClick,
    this.isPaying,
    this.isReceiving,
    this.receivingAmount,
  });

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var lessDeviceHeight = 0.45 * deviceSize.height;
    var moreDeviceHeight = 0.2 * deviceSize.height;
    return Container(
      padding: const EdgeInsets.all(10),
      height: deviceSize.height < 400 ? lessDeviceHeight : moreDeviceHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: (isPaying && !isReceiving) || (!isPaying && isReceiving)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        isReceiving
                            ? 'Customer are owing you'
                            : 'You Owe People',
                      ),
                      Text(
                        'N$payingAmount',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: isReceiving ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Customer are owing you'),
                          Text(
                            'N$payingAmount',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 0.5,
                        color: Colors.black87,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('You Owe People'),
                          Text(
                            'N$payingAmount',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 0.5,
            color: Colors.black87,
          ),
          GestureDetector(
            onTap: onClick,
            child: Container(
              height: deviceSize.height < 400
                  ? 0.2 * lessDeviceHeight
                  : 0.2 * moreDeviceHeight,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        'VIEW BREAKDOWN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
