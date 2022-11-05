import 'package:flutter/material.dart';
import 'package:flutter_crud/database/db_helper.dart';
import 'package:flutter_crud/model/barang_masuk.dart';
import 'package:flutter_crud/ui/form_barang_masuk.dart';
import 'package:intl/intl.dart';

import '../theme/color.dart';
import '../theme/text_style.dart';

class BarangMasukPage extends StatefulWidget {
  const BarangMasukPage({super.key});

  @override
  State<BarangMasukPage> createState() => _BarangMasukPageState();
}

class _BarangMasukPageState extends State<BarangMasukPage> {
  List<BarangMasuk> allBarangMasuk = [];

  @override
  void initState() {
    super.initState();
    getAllBarangMasuk();
  }

  void getAllBarangMasuk() async {
    final result = await DbHelper().getAllBarangMasuk();
    setState(() {
      allBarangMasuk = result.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Barang Masuk"),
      ),
      body: ListView.builder(
        itemCount: allBarangMasuk.length,
        itemBuilder: (context, index) {
          final barangMasuk = allBarangMasuk[index];
          return Column(
            children: [
              ListTile(
                title: Text("${barangMasuk.barang?.namaBrg}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pengembali : ${barangMasuk.nama}"),
                    Text("Deskripsi : ${barangMasuk.deskripsi}"),
                    Text(
                      DateFormat.yMMMMEEEEd('id').format(
                        DateTime.parse(barangMasuk.createdAt ?? ""),
                      ),
                    )
                  ],
                ),
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
                    "${barangMasuk.jumlah}",
                    style: AppTextStyle.reg(color: kPrimaryColor, fontSize: 12),
                  ),
                ),
              ),
              const Divider(thickness: 2, height: 2),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const FormBarangMasuk()),
            ),
          ).then((value) => getAllBarangMasuk());
        },
      ),
    );
  }
}
