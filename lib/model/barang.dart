// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class Barang {
  int? id;
  String? namabarang;
  String? jumlah;
  String? deskripsi;
  String? jenis;

  Barang({this.id, this.namabarang, this.jumlah, this.deskripsi, this.jenis});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = namabarang;
    map['jumlah'] = jumlah;
    map['deskripsi'] = deskripsi;
    map['jenis'] = jenis;

    return map;
  }

  Barang.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.namabarang = map['nama barang'];
    this.jumlah = map['jumlah'];
    this.deskripsi = map['deskripsi'];
    this.jenis = map['jenis'];
  }
}
