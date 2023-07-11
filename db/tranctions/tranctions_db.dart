import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage_app/models/tranctions/tranctions_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTranction(String id);
}

class TransactionDB implements TransactionDbFunction {
  
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> tranctionListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
   final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _db.put(obj.id, obj);
  }

  Future<void> refresh() async{
       final _list = await getAllTransactions();
       _list.sort((first,second)=> second.date.compareTo(first.date));
       tranctionListNotifier.value.clear();
       tranctionListNotifier.value.addAll(_list);
       tranctionListNotifier.notifyListeners();

  }
  
  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return  _db.values.toList();
  }
  
  @override
  Future<void> deleteTranction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
   
  }
  
}