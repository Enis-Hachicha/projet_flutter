import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testapp/pages/Journal.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String journalitemsTable = 'journalitems';
  String taskitemsTable = 'taskitems';
  String colId = 'id';
  String colName = 'name';
  String colIsFinished = 'isFinished';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'shopping_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $journalitemsTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT NOT NULL, $colIsFinished INTEGER NOT NULL),'
      'CREATE TABLE $taskitemsTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT NOT NULL, $colIsFinished INTEGER NOT NULL)'
    );
  }

  Future<int> insertJournalItem(String journalItem) async {
    final db = await instance.db;
    return await db!.insert(journalitemsTable, {colName :journalItem});
  }

  Future<int> updateJournalItem(int id,String journalItem) async {
    final db = await instance.db;
    return await db!.update(journalitemsTable, {colName :journalItem},
        where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteJournalItem(int id) async {
    final db = await instance.db;
    return await db!.delete(journalitemsTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<List<String>> getAllJournalItems() async {
    final db = await instance.db;
    final maps = await db!.query(journalitemsTable);
    return maps.isNotEmpty ? maps.map((map) => map.toString()).toList() : [];
  }
  Future<int> insertTaskItem(String taskItem) async {
    final db = await instance.db;
    return await db!.insert(taskitemsTable, {colName :taskItem});
  }

  Future<int> updateTaskItem(int id, String taskItem) async {
    final db = await instance.db;
    return await db!.update(taskitemsTable, {colName :taskItem},
        where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteTaskItem(int id) async {
    final db = await instance.db;
    return await db!.delete(taskitemsTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<List<String>> getAllTaskItems() async {
    final db = await instance.db;
    final maps = await db!.query(taskitemsTable);
    return maps.isNotEmpty ? maps.map((map) => map.toString()).toList() : [];
  }

  Future close() async {
    final db = await instance.db;
    db!.close();
  }
}