import 'package:flutter/material.dart';
import 'package:flutter_crud/theme/color.dart';

import '../database/db_helper.dart';
import '../model/barang.dart';

class FormBarang extends StatefulWidget {
  final Barang? barang;

  const FormBarang({super.key, this.barang});

  @override
  _FormBarangState createState() => _FormBarangState();
}

class _FormBarangState extends State<FormBarang> {
  DbHelper db = DbHelper();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController? name;
  TextEditingController? jumlah;
  TextEditingController? deskripsi;
  TextEditingController? jenis;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.namaBrg);

    jumlah = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.jumlah);

    deskripsi = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.deskripsi);

    jenis = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.jenis);
  }

  @override
  void dispose() {
    name?.dispose();
    jumlah?.dispose();
    deskripsi?.dispose();
    jenis?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: (widget.barang == null)
              ? const Text('Tambah Barang')
              : const Text("Ubah Barang")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null) return "barang wajib di isi";
                  if (value.isEmpty) return "barang wajib di isi";
                  if (value.length < 2) return "barang minimal 2 karakter";
                  return null;
                },
                controller: name,
                decoration: InputDecoration(
                    labelText: 'Barang',
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
                controller: jumlah,
                validator: (value) {
                  if (value == null) return "jumlah wajib di isi";
                  if (value.isEmpty) return "jumlah wajib di isi";
                  if (int.tryParse(value) == null) return "jumlah tidak valid";
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
                top: 20,
              ),
              child: TextFormField(
                controller: deskripsi,
                minLines: 3,
                maxLines: 4,
                validator: (value) {
                  if (value == null) return "deskripsi wajib di isi";
                  if (value.isEmpty) return "deskripsi wajib di isi";
                  if (value.length < 2) return "deskripsi minimal 2 karakter";
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<String?>(
                  validator: ((value) {
                    if (value == null) return "jenis barang wajib di isi";
                    if (value.isEmpty) return "jenis barang wajib di isi";
                    return null;
                  }),
                  isDense: true,
                  borderRadius: BorderRadius.circular(12),
                  value: jenis?.text == "" ? "Alat" : jenis?.text,
                  hint: const Text("Pilih jenis barang"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: const <DropdownMenuItem<String?>>[
                    DropdownMenuItem(
                      child: Text("Alat"),
                      value: "Alat",
                    ),
                    DropdownMenuItem(
                      child: Text("Bahan"),
                      value: "Bahan",
                    ),
                  ],
                  onChanged: (value) {
                    setState(
                      () {
                        jenis?.text = value ?? "";
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: (widget.barang == null)
                    ? const Text('Tambah',
                        style: TextStyle(color: Colors.white))
                    : const Text('Ubah', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    if (jenis?.text.isEmpty ?? true) {
                      jenis?.text = "Alat";
                    }
                    upsertBarang();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> upsertBarang() async {
    if (widget.barang != null) {
      //update
      await db.updateBarang(Barang(
        idBrg: widget.barang!.idBrg,
        namaBrg: name!.text,
        jumlah: jumlah!.text,
        deskripsi: deskripsi!.text,
        jenis: jenis!.text,
      ));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveBarang(Barang(
        namaBrg: name!.text,
        jumlah: jumlah!.text,
        deskripsi: deskripsi!.text,
        jenis: jenis!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
