// import 'dart:async';
// import 'package:sms/sms.dart';

// class SmsService {
//   SmsReceiver _receiver = new SmsReceiver();
//   SmsService() {
//     _receiver.onSmsReceived.listen(handler);
//   }
//   final _otpController = StreamController<SmsMessage>();

//   void handler(SmsMessage message) {
//     _otpController.add(message);
//   }
// }

import 'package:url_launcher/url_launcher.dart';
 class MessageServices{
     void sendSms(String number) => launch("sms:$number");

 }