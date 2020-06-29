import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinField extends StatelessWidget {
  final String title;
  final Function(String s) onChange;
  final Function(String s) onCompleted;
  final Function(String s) onSubmitted;
  final Function(String s) validator;

  const PinField({
    Key key,
    this.title,
    this.onChange,
    this.onCompleted,
    this.onSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.yMargin(context, 3),
              horizontal: SizeConfig.xMargin(context, 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).appBarTheme.color,
                      fontSize: SizeConfig.textSize(context, 4.5),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 2.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.xMargin(context, 20),
                  ),
                  child: PinCodeTextField(
                    length: 4,
                    backgroundColor: const Color(0xFF333CC1),
                    obsecureText: true,
                    autoFocus: true,
                    animationType: AnimationType.scale,
                    textInputType: TextInputType.number,
                    enableActiveFill: true,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textSize(context, 5),
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(20),
                      selectedFillColor:
                          const Color.fromARGB(70, 255, 255, 255),
                      activeFillColor: Colors.white,
                      inactiveFillColor:
                          const Color.fromARGB(70, 255, 255, 255),
                      selectedColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: const Color.fromARGB(70, 255, 255, 255),
                      borderWidth: 2,
                      fieldWidth: 14,
//                              fieldWidth: SizeConfig.xMargin(context, 3),
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    //errorAnimationController: errorController,
                    //controller: textEditingController,
                    autoDisposeControllers: false,
                    onCompleted: onCompleted,
                    onChanged: onChange,
                    onSubmitted: onSubmitted,
                    validator: validator,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
