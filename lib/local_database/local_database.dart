import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'db_position.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  /// single instance for all database query
  /// use this instance to interact with the database
  static final LocalDatabase instance = LocalDatabase._init();

  /// private database instance
  static Database? _database;

  /// singleton init
  LocalDatabase._init();

  /// get the database
  /// initiate database if not initiated
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(dbName: "positions.db");
    return _database!;
  }

  /// initiate database into system
  Future<Database> _initDB({required String dbName}) async {
    var dbPath = "";
    try {
      if (Platform.isAndroid) {
        /// for android only
        dbPath = await getDatabasesPath();
      } else {
        /// for iOS and macOS
        dbPath = (await getLibraryDirectory()).path;
      }
    } catch (e) {
      /// default on error
      dbPath = await getDatabasesPath();
      log("[error] [$runtimeType] [_initDB] $e");
    }
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// create all the tables
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    await db.execute('''
      CREATE TABLE $tablePositions (
        ${DBPositionFields.id} $idType,
        ${DBPositionFields.latitude} $doubleType,
        ${DBPositionFields.longitude} $doubleType,
        ${DBPositionFields.altitude} $doubleType,
        ${DBPositionFields.accuracy} $doubleType,
        ${DBPositionFields.dateTime} $textType
      )
      ''');
  }

  Future<int> save(DBPosition dbPosition) async {
    try {
      dbPosition.id = null;
      final db = await instance.database;
      return await db.insert(tablePositions, dbPosition.toMap());
    } catch (err) {
      return Future.value(0);
    }
  }

  Future<List<DBPosition>> getAll() async {
    try {
      final db = await instance.database;
      final List<DBPosition> dbPositions = [];
      final dataSet = await db.query(
        tablePositions,
        limit: 1000,
        orderBy: '${DBPositionFields.id} desc',
        columns: DBPositionFields.dbPositionFieldValues,
      );

      if (dataSet.isNotEmpty) {
        for (final element in dataSet) {
          dbPositions.add(DBPosition.fromJson(element));
        }
      }

      return Future.value(dbPositions);
    } catch (err) {
      return Future.value([]);
    }
  }

  Future<int> deleteById({required int id}) async {
    try {
      final db = await instance.database;
      return await db.delete(
        tablePositions,
        whereArgs: [id],
        where: '${DBPositionFields.id} = ?',
      );
    } catch (err) {
      return Future.value(0);
    }
  }

  Future<int> deleteAll() async {
    try {
      final db = await instance.database;
      return await db.delete(tablePositions);
    } catch (err) {
      return Future.value(0);
    }
  }
}
