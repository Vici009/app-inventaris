import 'package:flutter/material.dart';
import 'package:flutter_crud/ui/form_barang_masuk.dart';

import '../theme/color.dart';
import '../theme/text_style.dart';

class BarangMasukPage extends StatelessWidget {
  const BarangMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Barang Masuk"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("Nama Barang ke $index"),
              subtitle: const Text("Peminjam : Budi"),
              trailing: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  // color: kPrimaryColor,
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Text(
                  "4",
                  style: AppTextStyle.reg(color: kPrimaryColor, fontSize: 12),
                ),
              ),
            ),
            const Divider(thickness: 2, height: 2),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const FormBarangMasuk()),
            ),
          );
        },
      ),
    );
  }
}
