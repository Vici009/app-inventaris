import 'package:flutter/material.dart';
import 'package:flutter_crud/database/db_helper.dart';
import 'package:flutter_crud/model/barang_keluar.dart';
import 'package:flutter_crud/ui/form_barang_keluar.dart';
import 'package:intl/intl.dart';

import '../theme/color.dart';
import '../theme/text_style.dart';

class BarangKeluarPage extends StatefulWidget {
  const BarangKeluarPage({super.key});

  @override
  State<BarangKeluarPage> createState() => _BarangKeluarPageState();
}

class _BarangKeluarPageState extends State<BarangKeluarPage> {
  List<BarangKeluar> allBarangKeluar = [];

  @override
  void initState() {
    super.initState();
    getAllBarangKeluar();
  }

  void getAllBarangKeluar() async {
    final result = await DbHelper().getAllBarangKeluar();
    setState(() {
      allBarangKeluar = result.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Barang Keluar"),
      ),
      body: ListView.builder(
        itemCount: allBarangKeluar.length,
        itemBuilder: (context, index) {
          final barangKeluar = allBarangKeluar[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: (barangKeluar.barang?.jenis == "Alat")
                      ? const Icon(Icons.handyman)
                      : const Icon(Icons.hive),
                ),
                title: Text("${barangKeluar.barang?.namaBrg}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Peminjam : ${barangKeluar.nama}"),
                    Text("Deskripsi : ${barangKeluar.deskripsi}"),
                    Text(
                      DateFormat.yMMMMEEEEd('id').format(
                        DateTime.parse(barangKeluar.createdAt ?? ""),
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
                    "${barangKeluar.jumlah}",
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
              builder: ((context) => const FormBarangKeluar()),
            ),
          ).then((value) => getAllBarangKeluar());
        },
      ),
    );
  }
}
