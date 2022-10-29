// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/DbHelperkeluar.dart';
import 'model/barangkeluar.dart';

class FormBarangKeluar extends StatefulWidget {
  final BarangKeluar? barangKeluar;

  FormBarangKeluar({this.barangKeluar});

  @override
  _FormBarangKeluarState createState() => _FormBarangKeluarState();
}

class _FormBarangKeluarState extends State<FormBarangKeluar> {
  DbHelperKeluar dbk = DbHelperKeluar();

  TextEditingController? id_brg;
  TextEditingController? jumlah;
  TextEditingController? waktu;
  TextEditingController? deskripsi;

  @override
  void initState() {
    super.initState();
    id_brg = TextEditingController(
        text: widget.barangKeluar == null ? '' : widget.barangKeluar!.idbarang);

    jumlah = TextEditingController(
        text: widget.barangKeluar == null ? '' : widget.barangKeluar!.jumlah);

    waktu = TextEditingController(
        text: widget.barangKeluar == null ? '' : widget.barangKeluar!.waktu);

    deskripsi = TextEditingController(
        text: widget.barangKeluar == null ? '' : widget.barangKeluar!.deskripsi);
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
              controller: id_brg,
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
                value: waktu?.text == "" ? null : waktu?.text,
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
                      waktu?.text = value ?? "";
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
              controller: deskripsi,
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
              child: (widget.barangKeluar == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertBarangKeluar();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertBarangKeluar() async {
    if (widget.barangKeluar != null) {
      //update
      await dbk.updateBarangKeluar(BarangKeluar.fromMap({
        'id': widget.barangKeluar!.idbrgkeluar,
        'nama': id_brg!.text,
        'jumlah': jumlah!.text,
        'kondisi': waktu!.text,
        'merek': deskripsi!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await dbk.saveBarangKeluar(BarangKeluar(
        idbarang: id_brg!.text,
        jumlah: jumlah!.text,
        waktu: waktu!.text,
        deskripsi: deskripsi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
