//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete

import 'package:flutter_crud/model/barang.dart';
import 'package:flutter_crud/model/barang_masuk.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableBarang';
  final String columnId = 'id_brg';
  final String columnNama = 'nama_brg';
  final String columnJumlah = 'jumlah';
  final String columnDeskripsi = 'deskripsi';
  final String columnJenis = 'jenis';

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
        "$columnDeskripsi TEXT,"
        "$columnJenis TEXT)";
    await db.execute(sql);
    var sqlBarangMasuk = "CREATE TABLE barang_masuk(id INTEGER PRIMARY KEY,"
        "barang_id INTEGER,"
        "nama TEXT,"
        "jumlah TEXT,"
        "deskripsi TEXT,"
        "created_at TEXT)";
    await db.execute(sqlBarangMasuk);
  }

  //insert ke database
  Future<int?> saveBarang(Barang barang) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, barang.toMap());
  }

  //insert ke database
  Future<int?> saveBarangMasuk(BarangMasuk barang) async {
    var dbClient = await _db;
    return await dbClient!.insert("barang_masuk", {
      "barang_id": barang.barang?.idBrg,
      "nama": barang.nama,
      "jumlah": barang.jumlah,
      "deskripsi": barang.deskripsi,
      "created_at": barang.createdAt,
    });
  }

  //read database
  Future<List<Barang>> getAllBarang() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNama,
      columnJenis,
      columnJumlah,
      columnDeskripsi
    ]);

    return result.toList().map((barang) => Barang.fromMap(barang)).toList();
  }

  //read database
  Future<List<BarangMasuk>> getAllBarangMasuk() async {
    var dbClient = await _db;
    var result = await dbClient!.query(
      "barang_masuk",
      columns: [
        "id",
        "barang_id",
        "nama",
        "jumlah",
        "deskripsi",
        "created_at",
      ],
    );

    List<BarangMasuk> barangMasuk = [];
    for (final data in result.toList()) {
      final barang = await getAllBarangById((data["barang_id"] as int));
      barangMasuk.add(BarangMasuk(
        id: (data["id"] as int),
        nama: data["nama"] as String,
        deskripsi: data["deskripsi"] as String,
        jumlah: data["jumlah"] as String,
        createdAt: data["created_at"] as String,
        barang: barang.first,
      ));
    }
    return barangMasuk;
  }

  Future<List<Barang>> getAllBarangByName(String? query) async {
    var dbClient = await _db;
    if (query == null) {
      return await getAllBarang();
    }
    var result = await dbClient!.query(
      tableName,
      columns: [
        columnId,
        columnNama,
        columnJenis,
        columnJumlah,
        columnDeskripsi
      ],
      where: "nama_brg = ?",
      whereArgs: [query],
    );

    return result.toList().map((barang) => Barang.fromMap(barang)).toList();
  }

  Future<List<Barang>> getAllBarangById(int? query) async {
    var dbClient = await _db;
    if (query == null) {
      return await getAllBarang();
    }
    var result = await dbClient!.query(
      tableName,
      columns: [
        columnId,
        columnNama,
        columnJenis,
        columnJumlah,
        columnDeskripsi
      ],
      where: "id_brg = ?",
      whereArgs: [query],
    );

    return result.toList().map((barang) => Barang.fromMap(barang)).toList();
  }

  //update database
  Future<int?> updateBarang(Barang barang) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, barang.toMap(),
        where: '$columnId = ?', whereArgs: [barang.idBrg]);
  }

  //hapus database
  Future<int?> deleteBarang(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
