// ignore_for_file: non_constant_identifier_names

//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete

import 'package:flutter_crud/model/barang.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableBarang';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnJumlah = 'jumlah';
  final String columnKondisi = 'kondisi';
  final String columnMerek = 'merek';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'barang.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT,"
        "$columnJumlah TEXT,"
        "$columnKondisi TEXT,"
        "$columnMerek TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveBarang(Barang barang) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, barang.toMap());
  }

  //read database
  Future<List?> getAllBarang() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNama,
      columnMerek,
      columnJumlah,
      columnKondisi
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateBarang(Barang barang) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, barang.toMap(),
        where: '$columnId = ?', whereArgs: [barang.id]);
  }

  //hapus database
  Future<int?> deleteBarang(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
