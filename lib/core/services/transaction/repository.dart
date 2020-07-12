import 'package:hive/hive.dart';

abstract class Repository<T extends HiveObject> {
  
  Future<void> addTransaction(T newObject);
  
  Future<List<T>> getTransactions(int id);
}