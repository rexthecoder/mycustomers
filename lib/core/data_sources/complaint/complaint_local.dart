import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/models/hive/complaint/complaint_h.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/http/http_service.dart';

abstract class ComplaintLocalDataSource {
  Future<void> init();

  Future<void> createComplaint(Complaint complaint);

  Future<Iterable<Complaint>> getComplaints(String storeId);

  Future<Complaint> getComplaint(String complaintId);

  Future<void> deleteComplaint(String complaintId);
}

// TODO: Properly implement the error handling
class ComplaintLocalDataSourceImpl implements ComplaintLocalDataSource {
  final _hiveService = locator<HiveInterface>();
  final HttpService _http = locator<HttpService>();
  final _auth = locator<AuthService>();

  static const COMPLAINT_HIVE_BOX_NAME = 'COMPLAINT';

  static Box<Complaint> complaintBox;

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
    await _hiveService.openBox<Complaint>(COMPLAINT_HIVE_BOX_NAME);
    complaintBox = _hiveService.box<Complaint>(COMPLAINT_HIVE_BOX_NAME);
  }

  @override
  Future<void> createComplaint(Complaint complaint) async {
    Complaint newComplaint;
    try {
      var response = await _http.postHttp('${ApiRoutes.base_url}/complaint/new', {
        'subject': complaint.subject,
        'message ': complaint.message,
        'name': _auth.currentUser.firstName,
        'email': _auth.currentUser.email,
      });
      newComplaint = Complaint.fromJson(response['data']['complaint']);
    } on DioError {}
    catch (e) {
      newComplaint = complaint;
    }
    complaintBox.put(newComplaint.id, newComplaint);
  }

  @override
  Future<void> deleteComplaint(String complaintId) async {
    try {
      var response = await _http.deleteHttp('${ApiRoutes.base_url}/complaint/delete/$complaintId');
      if (response['success']) {
        complaintBox.delete(complaintId);
      }
    } on DioError {
      rethrow;
    }
    catch (e) {
      Complaint complaintToDelete = complaintBox.get(complaintId);
      complaintToDelete.deleted = true;
    }
  }

  @override
  Future<Complaint> getComplaint(String complaintId) async {
    try {
      var response = (await _http.getHttp('${ApiRoutes.base_url}/complaint/$complaintId'));
      return Complaint.fromJson(response['data']['complaint']);
    } on DioError {
      rethrow;
    }
    catch (e) {
      return complaintBox.get(complaintId);
    }
  }

  @override
  Future<Iterable<Complaint>> getComplaints(String userId) async {
    try {
      var response = (await _http.getHttp('${ApiRoutes.base_url}/complaints'));
      return response['data']['complaints'].map<Complaint>((element) => Complaint.fromJson(element));
    } on DioError {
      rethrow;
    }
    catch (e) {
      return complaintBox.values.where((element) => element.sentFromId == userId);
    }
  }

}