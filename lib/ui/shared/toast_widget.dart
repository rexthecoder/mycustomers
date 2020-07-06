import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:oktoast/oktoast.dart';

ToastFuture showToastCustom(
    {Key key,
    message,
    success: false,
    color,
    Duration duration: const Duration(seconds: 2)}) {
  assert(success != null || color != null);
  return showToastWidget(
    ToastWidget(
      key: key,
      message: message,
      success: success,
      color: color,
    ),
    duration: duration,
    animationDuration: Duration(milliseconds: 500),
    animationCurve: Curves.easeInOutBack,
    dismissOtherToast: true,
  );
}

class ToastWidget extends StatelessWidget {
  final String message;
  final bool success;
  final Color color;

  const ToastWidget({Key key, this.message, this.success: false, this.color})
      : assert(success != null || color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor =
        (color?.computeLuminance() ?? 0) > 0.5 ? Colors.black : Colors.white;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: this.color ?? this.success
                ? ThemeColors.success
                : ThemeColors.error,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            this.message,
            style: TextStyle(
              color: textColor,
              fontSize: SizeConfig.yMargin(context, 3),
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
