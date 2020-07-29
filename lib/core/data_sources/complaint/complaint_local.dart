
import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/hive/complaint/complaint_h.dart';

abstract class ComplaintLocalDataSource {
  Future<void> createComplaint(Complaint complaint);

  Future<Iterable<Complaint>> getComplaints(String storeId);

  Future<Complaint> getComplaint(String complaintId);

  Future<void> deleteComplaint(String complaintId);
}

class ComplaintLocalDataSourceImpl implements ComplaintLocalDataSource {
  final _hiveService = locator<HiveInterface>();

  @override
  Future<void> createComplaint(Complaint complaint) {
    // TODO: implement createComplaint
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComplaint(String complaintId) {
    // TODO: implement deleteComplaint
    throw UnimplementedError();
  }

  @override
  Future<Complaint> getComplaint(String complaintId) {
    // TODO: implement getComplaint
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Complaint>> getComplaints(String storeId) {
    // TODO: implement getComplaints
    throw UnimplementedError();
  }

}