import 'package:calculadoraimc/models/history.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

String tableName = 'history';

Map<int, String> createScripts = {
  1: ''' CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    value DOUBLE NOT NULL,
    date INTEGER NOT NULL
  );'''
};

class ImcHistoryRepository{
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await open();
    } else {
      return db!;
    }
  }

  Future<Database> open() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: createScripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= createScripts.length; i++) {
        await db.execute(createScripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= createScripts.length; i++) {
        await db.execute(createScripts[i]!);
      }
    });
    return db;
  }

  Future<void> save(double value) async{
    var db = await getDatabase();
    History history = History(value);
    await db.insert(tableName, history.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(int id) async{
    var db = await getDatabase();
    await db.delete(tableName, where:'id=?', whereArgs:[id]);
  }

  Future<List<History>> getAll(size, page) async{
    var db = await getDatabase();
    List <Map<String, dynamic>> result = await db.query(tableName, orderBy: 'id DESC', offset: size*page+1, limit: size); 

    List<History> historyList = [];
    for (var element in result) {
      historyList.add(History.fromMap(element));
    }
    return historyList;
  }
}