// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/DbHelpermasuk.dart';
import 'model/barangmasuk.dart';

class FormBarangMasuk extends StatefulWidget {
  final BarangMasuk? barangMasuk;

  FormBarangMasuk({this.barangMasuk});

  @override
  _FormBarangMasukState createState() => _FormBarangMasukState();
}

class _FormBarangMasukState extends State<FormBarangMasuk> {
  DbHelperMasuk dbm = DbHelperMasuk();

  TextEditingController? id_brg;
  TextEditingController? jumlah;
  TextEditingController? waktu;
  TextEditingController? deskripsi;

  @override
  void initState() {
    super.initState();
    id_brg = TextEditingController(
        text: widget.barangMasuk == null ? '' : widget.barangMasuk!.idbarang);

    jumlah = TextEditingController(
        text: widget.barangMasuk == null ? '' : widget.barangMasuk!.jumlah);

    waktu = TextEditingController(
        text: widget.barangMasuk == null ? '' : widget.barangMasuk!.waktu);

    deskripsi = TextEditingController(
        text: widget.barangMasuk == null ? '' : widget.barangMasuk!.deskripsi);
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
              child: (widget.barangMasuk == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertBarangMasuk();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertBarangMasuk() async {
    if (widget.barangMasuk != null) {
      //update
      await dbm.updateBarangMasuk(BarangMasuk.fromMap({
        'id': widget.barangMasuk!.idbrgmasuk,
        'nama': id_brg!.text,
        'jumlah': jumlah!.text,
        'kondisi': waktu!.text,
        'merek': deskripsi!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await dbm.saveBarangMasuk(BarangMasuk(
        idbarang: id_brg!.text,
        jumlah: jumlah!.text,
        waktu: waktu!.text,
        deskripsi: deskripsi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
