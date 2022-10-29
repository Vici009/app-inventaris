import 'dart:convert';

class Barang {
  int? idBrg;
  String? namaBrg;
  String? jumlah;
  String? deskripsi;
  String? jenis;
  Barang({
    this.idBrg,
    this.namaBrg,
    this.jumlah,
    this.deskripsi,
    this.jenis,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_brg': idBrg,
      'nama_brg': namaBrg,
      'jumlah': jumlah,
      'deskripsi': deskripsi,
      'jenis': jenis,
    };
  }

  @override
  String toString() {
    return 'Barang(idBrg: $idBrg, namaBrg: $namaBrg, jumlah: $jumlah, deskripsi: $deskripsi, jenis: $jenis)';
  }

  @override
  bool operator ==(covariant Barang other) {
    if (identical(this, other)) return true;

    return other.idBrg == idBrg &&
        other.namaBrg == namaBrg &&
        other.jumlah == jumlah &&
        other.deskripsi == deskripsi &&
        other.jenis == jenis;
  }

  @override
  int get hashCode {
    return idBrg.hashCode ^
        namaBrg.hashCode ^
        jumlah.hashCode ^
        deskripsi.hashCode ^
        jenis.hashCode;
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      idBrg: map['id_brg'] != null ? map['id_brg'] as int : null,
      namaBrg: map['nama_brg'] != null ? map['nama_brg'] as String : null,
      jumlah: map['jumlah'] != null ? map['jumlah'] as String : null,
      deskripsi: map['deskripsi'] != null ? map['deskripsi'] as String : null,
      jenis: map['jenis'] != null ? map['jenis'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Barang.fromJson(String source) =>
      Barang.fromMap(json.decode(source) as Map<String, dynamic>);
}
