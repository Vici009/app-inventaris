// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class Barang {
  int? id;
  String? name;
  String? jumlah;
  String? kondisi;
  String? merek;

  Barang({this.id, this.name, this.jumlah, this.kondisi, this.merek});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = name;
    map['jumlah'] = jumlah;
    map['kondisi'] = kondisi;
    map['merek'] = merek;

    return map;
  }

  Barang.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['nama'];
    this.jumlah = map['jumlah'];
    this.kondisi = map['kondisi'];
    this.merek = map['merek'];
  }
}
