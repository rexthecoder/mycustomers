import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Initial on Contact {
  String get initial => (this == null) ? '.' : this.initials().isNotEmpty ? this.initials() : this.displayName[0].toUpperCase();
}

class CustomerCircleAvatar extends StatelessWidget {
  CustomerCircleAvatar({
    Key key,
    this.customer,
    this.child,
    this.bgColor, this.contact,
  }) : super(key: key) {
    assert((customer != null) || (child != null) || (contact != null));
  }

  final Customer customer;
  final Contact contact;
  final Widget child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: this.child != null ? this.child : this.contact != null && this.contact.avatar.isNotEmpty ? Image.memory(this.contact.avatar, fit: BoxFit.cover,) :
          Text(
            '${customer?.name?.substring(0, 1) ?? contact?.initial ?? '(*)'}${customer?.lastName?.substring(0, 1) ?? ''}'.toUpperCase(),
            style: TextStyle(
              color: BrandColors.primary,
              fontSize: 24.sp,
            ),
          ),
      radius: 30.w,
      backgroundColor: this.bgColor ?? BrandColors.primary.withOpacity(0.3),
    );
  }
}
