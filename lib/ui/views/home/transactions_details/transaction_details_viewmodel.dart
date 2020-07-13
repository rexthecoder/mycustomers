import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TransactionDetailsViewModel extends ReactiveViewModel{
  final NavigationService _navigationService = locator<NavigationService>();
  
  final _customerContactService = locator<CustomerContactService>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  CustomerContact get contact => _customerContactService.contact;
  TransactionModel get transaction => _transactionService.stransaction;

  String name = 'Seyi Onifade';
  int phoneNumber = 09045678901;
  String itemsPurchased = '2 Crates of 50CL Coke';
  int costOfItems = 50000;
  int amountPaid = 20000;
  int amountOwing = 30000;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService, _customerContactService];
}