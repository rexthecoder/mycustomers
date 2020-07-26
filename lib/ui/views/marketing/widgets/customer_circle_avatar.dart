import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

extension Initial on Contact {
  String get initial => (this == null) ? '.' : this.initials().isNotEmpty ? this.initials() : this.displayName[0].toUpperCase();
}

class CustomerCircleAvatar extends StatelessWidget {
  CustomerCircleAvatar({
    Key key,
    this.customer,
    this.child,
    this.bgColor, this.contact, this.action, this.ccustomer
  }) : super(key: key) {
    assert((customer != null) || (ccustomer != null)  || (child != null) || (contact != null));
  }

  final Customer customer;
  final CustomerContact ccustomer;
  final Contact contact;
  final Widget child;
  final Color bgColor;
  final String action;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: this.child != null ? this.child : this.contact != null && this.contact.avatar.isNotEmpty ? Image.memory(this.contact.avatar, fit: BoxFit.cover,) :
          Text(
            customer != null ? '${customer.displayName.split(" ").length > 2 ? customer.displayName.split(" ")[0][0]+""+customer.displayName.split(" ")[1][0] ?? "" : customer.displayName[0]}' : '${ccustomer.initials}',
            //'${customer?.name[0]?? contact?.initial ?? '(*)'}${customer.lastName ==''?'': customer?.lastName[0] ?? ''}'.toUpperCase(),
            style: TextStyle(
              color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
              fontSize: SizeConfig.yMargin(context, 2),
              fontFamily: 'Roboto'
            ),
          ),
      radius: SizeConfig.xMargin(context, 6),
      backgroundColor: this.bgColor != null ? this.bgColor : action == 'debtor' ? BrandColors.primary.withOpacity(0.3) : BrandColors.secondary.withOpacity(0.3),
    );
  }
}
