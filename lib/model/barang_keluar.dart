// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class BarangKeluar {
  int? idbrgkeluar;
  String? idbarang;
  String? jumlah;
  String? waktu;
  String? deskripsi;

  BarangKeluar({this.idbrgkeluar, this.idbarang, this.jumlah, this.waktu, this.deskripsi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (idbrgkeluar != null) {
      map['id_brg_keluar'] = idbrgkeluar;
    }
    map['id_brg'] = idbarang;
    map['jumlah'] = jumlah;
    map['waktu'] = waktu;
    map['deskripsi'] = deskripsi;

    return map;
  }

  BarangKeluar.fromMap(Map<String, dynamic> map) {
    this.idbrgkeluar = map['id_brg_keluar'];
    this.idbarang = map['id_brg'];
    this.jumlah = map['jumlah'];
    this.waktu = map['waktu'];
    this.deskripsi = map['deskripsi'];
  }
}
