<<<<<<< HEAD
import 'dart:async';
import 'package:sms/sms.dart';

  class SmsService {
  SmsReceiver _receiver = new SmsReceiver();
  SmsService() {
    _receiver.onSmsReceived.listen(handler);
}
     // ignore: close_sinks
     final _otpController = StreamController<SmsMessage>();
void handler(SmsMessage message) {
   // ignore: unused_local_variable
   var add = _otpController.sink.add(message);
}
}



=======
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
>>>>>>> upstream/master
