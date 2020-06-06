import 'dart:io';
import 'dart:core';
import './models/pedalSettings.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static final _databaseName = 'phonegazer.db';
  static final _databaseVersion = 1;

  static final table = 'pedalTable';

  static final colId = 'id';
  static final colPedalName = 'pedalName';
  static final colEffectType = 'effectType';
  static final colParameters = 'parameters';
  static final colNotes = 'notes';

  // make this a singleton class
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $colId INTEGER PRIMARY KEY,
        $colPedalName TEXT NOT NULL,
        $colEffectType TEXT NOT NULL,
        $colParameters TEXT NOT NULL,
        $colNotes TEXT NOT NULL
      );
      ''');
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Pedal pedals) async {
    Database db = await instance.database;
    return await db.insert(table, 
        {'pedalName': pedals.pedalName, 'effectType': pedals.effectType,'parameters': pedals.parameters, 'notes': pedals.notes});
  }

  // all of the rows are returned as a list of maps, where each map is
  // a key-value list of columns
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$colPedalName LIKE '%$name%'");
  }

  Future<int> update(Pedal pedals) async {
    Database db = await instance.database;
    int id = pedals.toMap()['id'];
    return await db.update(table, pedals.toMap(), where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$colId = ?', whereArgs: [id]);
  }
}
