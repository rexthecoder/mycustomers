import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:mycustomers/core/utils/logger.dart';

class TransactionDetailsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final _customerContactService = locator<CustomerContactService>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  CustomerContact get contact => _customerContactService.contact;
  TransactionModel get transaction => _transactionService.stransaction;
  final PermissionService _permissionService = locator<IPermissionService>();

  final dformat = new DateFormat('dd/MM/yyyy');

  File imageFile;

  void delete() {
    _navigationService.back();
    _transactionService.deleteTransaction(contact);
  }

  void edit() {
    transaction.amount > transaction.paid
        ? _navigationService.navigateTo(Routes.selectRouteDebt)
        : _navigationService.navigateTo(Routes.selectRouteCredit);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_transactionService, _customerContactService];

  Future<void> shareImageAndText() async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      final String fileName = '${contact.name}-transaction-details.png';

      await WcFlutterShare.share(
        sharePopupTitle: 'Share your transaction details',
        subject: contact.name,
        text: 'myCustomer transaction details with ${contact.name}',
        fileName: fileName,
        mimeType: 'image/png',
        bytesOfFile: bytes.buffer.asUint8List(),
      );
    } catch (e) {
      Logger.e(e);
      throw Exception("Unable to save image");
    }
  }

  Future<void> downloadImage() async {
    try {
      if (await _permissionService.getStoragePermission()) {
        final Uint8List bytes = await imageFile.readAsBytes();

        final String internalStorage = '/storage/emulated/0/myCustomer';

        final String fileName = '${contact.name}-transaction-detail.png';

        bool isDirExist = await Directory(internalStorage).exists();
        if (!isDirExist) Directory(internalStorage).create();
        String tempPath = '$internalStorage/$fileName';
        File(tempPath).writeAsBytes(bytes);
      }
    } catch (e) {
      Logger.e(e);
      throw Exception("Unable to download image");
    }
  }
}
