import 'dart:async';
import 'dart:io';

import 'package:encrypted_db/credit_card.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class _DBConfiguration {
  final String path;
  final String password;
  final bool isAsset;

  _DBConfiguration({this.path, this.password, this.isAsset = false});

  String get name => this.path.split("/").last;
}

class DBService {
  Database _database;
  final _DBConfiguration _dbConf;

  DBService({String name, String password, bool isAsset = false}) :
      _dbConf = _DBConfiguration(
        path: name,
        password: password,
        isAsset: isAsset,
      );

  Future<Database> get _db async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    if(_dbConf.isAsset) {
      await _copyAssetToLocal();
    }
    print("Database path: ${await getDatabasesPath()}");
    _database = await openDatabase(
      _dbConf.name,
      password: _dbConf.password,
      onCreate: DBService._onCreate,
      version: 1,
    );
    return _database;
  }

  Future<void> _copyAssetToLocal() async {
    final path =  "${await getDatabasesPath()}${Platform.pathSeparator}${_dbConf.name}";
    if(!File(path).existsSync()) {
      ByteData data = await rootBundle.load(_dbConf.path);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true, mode: FileMode.write);
    }
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE credit_card (
    id INTEGER PRIMARY KEY, 
    last_name TEXT,
    type TEXT,
    card_id TEXT,
    cryptogram TEXT,
    expiration_month INTEGER,
    expiration_year INTEGER)
    ''');
  }

  Future<int> insertSensitiveData(CreditCard creditCard) async {
    final db = await _db;
    return db.insert("credit_card", creditCard.attributes);
  }

  Future<List<CreditCard>> allCards() async {
    final db = await _db;
    final cursor = await db.query("credit_card");
    return cursor.map((data) => CreditCard.fromMap(data: data)).toList();
  }
}
