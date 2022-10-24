// ignore_for_file: non_constant_identifier_names

//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete

import 'package:flutter_crud/model/barangkeluar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelperKeluar {
  static final DbHelperKeluar _instance = DbHelperKeluar._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableBarangKeluar';
  final String columnId = 'id_brg_keluar';
  final String columnIdBarang = 'id_brg';
  final String columnJumlah = 'jumlah';
  final String columnWaktu = 'waktu';
  final String columnDeskripsi = 'deskripsi';

  DbHelperKeluar._internal();
  factory DbHelperKeluar() => _instance;

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
    String path = join(databasePath, 'barangKeluar.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnIdBarang TEXT,"
        "$columnJumlah TEXT,"
        "$columnWaktu TIMESTAMP,"
        "$columnDeskripsi TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveBarangKeluar(BarangKeluar barangKeluar) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, barangKeluar.toMap());
  }

  //read database
  Future<List?> getAllBarangKeluar() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnIdBarang,
      columnWaktu,
      columnJumlah,
      columnDeskripsi
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateBarangKeluar(BarangKeluar barangKeluar) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, barangKeluar.toMap(),
        where: '$columnId = ?', whereArgs: [barangKeluar.id_brg_keluar]);
  }

  //hapus database
  Future<int?> deleteBarangKeluar(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
