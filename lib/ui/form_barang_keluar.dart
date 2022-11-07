import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/database/db_helper.dart';
import 'package:flutter_crud/model/barang_keluar.dart';

import '../model/barang.dart';
import '../theme/color.dart';

class FormBarangKeluar extends StatefulWidget {
  const FormBarangKeluar({super.key});

  @override
  State<FormBarangKeluar> createState() => _FormBarangKeluarState();
}

class _FormBarangKeluarState extends State<FormBarangKeluar> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jumlahBarangController = TextEditingController();
  final TextEditingController deskripsiBarangController =
  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  Barang? barang;

  @override
  void dispose() {
    namaController.dispose();
    jumlahBarangController.dispose();
    deskripsiBarangController.dispose();
    super.dispose();
  }

  void updateBarang(Barang? newBarang) {
    barang = newBarang;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Barang Keluar")),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  DropdownSearch<Barang>(
                    asyncItems: (String filter) => getData(),
                    enabled: true,
                    itemAsString: (Barang barang) => barang.namaBrg ?? "",
                    filterFn: (item, filter) {
                      return item.namaBrg?.toLowerCase().contains(
                        filter.toLowerCase(),
                      ) ??
                          false;
                    },
                    compareFn: (item1, item2) {
                      return item1.namaBrg?.toLowerCase() ==
                          item2.namaBrg?.toLowerCase();
                    },
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      isFilterOnline: false,
                      showSelectedItems: true,
                      emptyBuilder: (context, info) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "barang tidak ditemukan",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, log) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Terjadi kesalahan",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    onChanged: (Barang? data) {
                      updateBarang(data);
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration:
                      InputDecoration(labelText: "Cari Barang"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null) return "nama wajib di isi";
                        if (value.isEmpty) return "nama wajib di isi";
                        if (value.length < 2) {
                          return "Nama minimal 2 karakter";
                        }
                        return null;
                      },
                      controller: namaController,
                      decoration: InputDecoration(
                          labelText: 'Nama',
                          isDense: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      controller: jumlahBarangController,
                      validator: (value) {
                        if (value == null) return "jumlah wajib di isi";
                        if (value.isEmpty) return "jumlah wajib di isi";
                        if (int.tryParse(value) == null) {
                          return "jumlah tidak valid";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Jumlah',
                          isDense: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: TextFormField(
                      controller: deskripsiBarangController,
                      minLines: 3,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null) return "deskripsi wajib di isi";
                        if (value.isEmpty) return "deskripsi wajib di isi";
                        if (value.length < 2) {
                          return "deskripsi minimal 2 karakter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          isDense: true,
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor),
                    onPressed: () {
                      if ((formKey.currentState?.validate() ?? false) &&
                          barang != null) {
                        DbHelper().saveBarangKeluar(
                          BarangKeluar(
                              nama: namaController.text,
                              jumlah: jumlahBarangController.text,
                              deskripsi: deskripsiBarangController.text,
                              createdAt: DateTime.now().toIso8601String(),
                              barang: barang),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<List<Barang>> getData() async {
    return DbHelper().getAllBarang();
  }
}
