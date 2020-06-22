import 'dart:async';
import 'package:sms/sms.dart';

  class SmsService {
  SmsReceiver _receiver = new SmsReceiver();
  SmsService() {
    _receiver.onSmsReceived.listen(handler);
}
     final _otpController = StreamController<SmsMessage>();
void handler(SmsMessage message) {
   var add = _otpController.sink.add(message);
}
}



