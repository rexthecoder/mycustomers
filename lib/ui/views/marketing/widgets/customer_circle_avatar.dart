import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerCircleAvatar extends StatelessWidget {
  CustomerCircleAvatar({
    Key key,
    this.customer,
    this.child,
    this.bgColor,
  }) : super(key: key) {
    assert(customer != null || child != null);
  }

  final Customer customer;
  final Widget child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: this.child ??
          Text(
            '${customer.name.substring(0, 1)}${customer.lastName?.substring(0, 1) ?? ''}'.toUpperCase(),
            style: TextStyle(
              color: BrandColors.secondary,
              fontSize: 24.sp,
            ),
          ),
      radius: 30.w,
      backgroundColor: this.bgColor ?? BrandColors.secondary.withOpacity(0.3),
    );
  }
}
