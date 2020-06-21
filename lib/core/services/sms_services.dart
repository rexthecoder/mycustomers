import 'package:sms/sms.dart';


  class SmsService {
  SmsReceiver receiver = new SmsReceiver();

   receiver.onSmsReceived.listen(handler);
}

  SmsReciever receiver = SmsReciever();

     final otpController = StreamController<SmsMessage>();

void handler(SmsMessage message) {

   otpController.sink.add(message);
}