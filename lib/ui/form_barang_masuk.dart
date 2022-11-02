import 'package:flutter/material.dart';

class FormBarangMasuk extends StatelessWidget {
  const FormBarangMasuk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Barang Masuk")),
      body: const Center(
        // Cari barang
        // Nama
        // Jumlah
        // Deskripsi
        child: Text("Form barang masuk"),
      ),
    );
  }
}
