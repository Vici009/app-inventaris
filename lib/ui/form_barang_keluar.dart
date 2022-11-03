import 'package:flutter/material.dart';

class FormBarangKeluar extends StatelessWidget {
  const FormBarangKeluar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Barang Keluar")),
      body: const Center(
        // Cari barang
        // Nama
        // Jumlah
        // Deskripsi
        child: Text("Form barang keluar"),
      ),
    );
  }
}
