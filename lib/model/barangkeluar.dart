// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class BarangKeluar {
  int? id_brg_keluar;
  int? id_brg;
  String? jumlah;
  String? waktu;
  String? deskripsi;

  BarangKeluar({this.id_brg_keluar, this.id_brg, this.jumlah, this.waktu, this.deskripsi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id_brg_keluar != null) {
      map['id_brg_keluar'] = id_brg_keluar;
    }
    map['id_brg'] = id_brg;
    map['jumlah'] = jumlah;
    map['waktu'] = waktu;
    map['deskripsi'] = deskripsi;

    return map;
  }

  BarangKeluar.fromMap(Map<String, dynamic> map) {
    this.id_brg_keluar = map['id_brg_keluar'];
    this.id_brg = map['id_brg'];
    this.jumlah = map['jumlah'];
    this.waktu = map['waktu'];
    this.deskripsi = map['deskripsi'];
  }
}
