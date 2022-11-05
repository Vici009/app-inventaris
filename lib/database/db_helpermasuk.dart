// //dbhelper ini dibuat untuk
// //membuat database, membuat tabel, proses insert, read, update dan delete

// import 'package:flutter_crud/model/barang_masuk.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DbHelperMasuk {
//   static final DbHelperMasuk _instance = DbHelperMasuk._internal();
//   static Database? _database;

//   //inisialisasi beberapa variabel yang dibutuhkan
//   final String tableName = 'tableBarangMasuk';
//   final String columnId = 'id_brg_masuk';
//   final String columnIdBarang = 'id_brg';
//   final String columnJumlah = 'jumlah';
//   final String columnWaktu = 'waktu';
//   final String columnDeskripsi = 'deskripsi';

//   DbHelperMasuk._internal();
//   factory DbHelperMasuk() => _instance;

//   //cek apakah database ada
//   Future<Database?> get _db async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await _initDb();
//     return _database;
//   }

//   Future<Database?> _initDb() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'barang.db');

//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   //membuat tabel dan field-fieldnya
//   Future<void> _onCreate(Database db, int version) async {
//     var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
//         "$columnIdBarang TEXT,"
//         "$columnJumlah TEXT,"
//         "$columnWaktu TIME,"
//         "$columnDeskripsi TEXT)";
//     await db.execute(sql);
//   }

//   //insert ke database
//   Future<int?> saveBarangMasuk(BarangMasuk barangMasuk) async {
//     var dbClient = await _db;
//     return await dbClient!.insert(tableName, barangMasuk.toMap());
//   }

//   //read database
//   Future<List?> getAllBarang() async {
//     var dbClient = await _db;
//     var result = await dbClient!.query(tableName, columns: [
//       columnId,
//       columnIdBarang,
//       columnWaktu,
//       columnJumlah,
//       columnDeskripsi
//     ]);

//     return result.toList();
//   }

//   //update database
//   Future<int?> updateBarangMasuk(BarangMasuk barangMasuk) async {
//     var dbClient = await _db;
//     return await dbClient!.update(tableName, barangMasuk.toMap(),
//         where: '$columnId = ?', whereArgs: [barangMasuk.idbrgmasuk]);
//   }

//   //hapus database
//   Future<int?> deleteBarangMasuk(int id) async {
//     var dbClient = await _db;
//     return await dbClient!
//         .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
//   }
// }
