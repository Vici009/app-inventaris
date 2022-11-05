// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_crud/model/barang.dart';

class BarangMasuk {
  int? id;
  String? nama;
  String? jumlah;
  String? deskripsi;
  String? createdAt;
  Barang? barang;
  BarangMasuk({
    this.id,
    this.nama,
    this.jumlah,
    this.deskripsi,
    this.createdAt,
    this.barang,
  });

  BarangMasuk copyWith({
    int? id,
    String? nama,
    String? jumlah,
    String? deskripsi,
    String? createdAt,
    Barang? barang,
  }) {
    return BarangMasuk(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      jumlah: jumlah ?? this.jumlah,
      deskripsi: deskripsi ?? this.deskripsi,
      createdAt: createdAt ?? this.createdAt,
      barang: barang ?? this.barang,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'jumlah': jumlah,
      'deskripsi': deskripsi,
      'createdAt': createdAt,
      'barang': barang?.toMap(),
    };
  }

  factory BarangMasuk.fromMap(Map<String, dynamic> map) {
    return BarangMasuk(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jumlah: map['jumlah'] != null ? map['jumlah'] as String : null,
      deskripsi: map['deskripsi'] != null ? map['deskripsi'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      barang: map['barang'] != null
          ? Barang.fromMap(map['barang'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BarangMasuk.fromJson(String source) =>
      BarangMasuk.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BarangMasuk(id: $id, nama: $nama, jumlah: $jumlah, deskripsi: $deskripsi, createdAt: $createdAt, barang: $barang)';
  }

  @override
  bool operator ==(covariant BarangMasuk other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nama == nama &&
        other.jumlah == jumlah &&
        other.deskripsi == deskripsi &&
        other.createdAt == createdAt &&
        other.barang == barang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nama.hashCode ^
        jumlah.hashCode ^
        deskripsi.hashCode ^
        createdAt.hashCode ^
        barang.hashCode;
  }
}
