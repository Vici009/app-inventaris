// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class BarangMasuk {
  int? idbrgmasuk;
  String? idbarang;
  String? jumlah;
  String? waktu;
  String? deskripsi;

  BarangMasuk({this.idbrgmasuk, this.idbarang, this.jumlah, this.waktu, this.deskripsi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (idbrgmasuk != null) {
      map['id_brg_masuk'] = idbrgmasuk;
    }
    map['id_brg'] = idbarang;
    map['jumlah'] = jumlah;
    map['waktu'] = waktu;
    map['deskripsi'] = deskripsi;

    return map;
  }

  BarangMasuk.fromMap(Map<String, dynamic> map) {
    this.idbrgmasuk = map['id_brg_masuk'];
    this.idbarang = map['id_brg'];
    this.jumlah = map['jumlah'];
    this.waktu = map['waktu'];
    this.deskripsi = map['deskripsi'];
  }
}
