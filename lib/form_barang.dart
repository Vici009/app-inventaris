// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/DbHelper.dart';
import 'model/barang.dart';

class FormBarang extends StatefulWidget {
  final Barang? barang;

  FormBarang({this.barang});

  @override
  _FormBarangState createState() => _FormBarangState();
}

class _FormBarangState extends State<FormBarang> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? jumlah;
  TextEditingController? deskripsi;
  TextEditingController? jenis;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.namabarang);

    jumlah = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.jumlah);

    deskripsi = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.deskripsi);

    jenis = TextEditingController(
        text: widget.barang == null ? '' : widget.barang!.jenis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text('Form Barang'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: jumlah,
              decoration: InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String?>(
                value: deskripsi?.text == "" ? null : deskripsi?.text,
                hint: Text("Pilih kondisi barang"),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const <DropdownMenuItem<String?>>[
                  DropdownMenuItem(
                    child: Text("Bagus"),
                    value: "Bagus",
                  ),
                  DropdownMenuItem(
                    child: Text("Rusak"),
                    value: "Rusak",
                  ),
                ],
                onChanged: (value) {
                  setState(
                    () {
                      deskripsi?.text = value ?? "";
                    },
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 20,
          //   ),
          //   child: TextField(
          //     controller: email,
          //     decoration: InputDecoration(
          //         labelText: 'Kondisi',
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         )),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: jenis,
              decoration: InputDecoration(
                  labelText: 'Merek',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.barang == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertBarang();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertBarang() async {
    if (widget.barang != null) {
      //update
      await db.updateBarang(Barang.fromMap({
        'id': widget.barang!.id,
        'nama': name!.text,
        'jumlah': jumlah!.text,
        'kondisi': deskripsi!.text,
        'merek': jenis!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveBarang(Barang(
        namabarang: name!.text,
        jumlah: jumlah!.text,
        deskripsi: deskripsi!.text,
        jenis: jenis!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
