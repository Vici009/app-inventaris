// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  Barang? selectedBarang ;
  List<Barang> barangs = [
    Barang("Komputer"),
    Barang("Mouse")
  ];

  List<DropdownMenuItem> generateItems(List<Barang> barangs) {
    List<DropdownMenuItem> items = [];
    for (var item in barangs) {
    items.add(DropdownMenuItem(child: Text(item.name), value: item,));
    }
    return items;
  }
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);

    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);

    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);

    company = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Form Kontak'),
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
          // DropdownButton(items: items, onChanged: onChanged),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: mobileNo,
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
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Kondisi',
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
              controller: company,
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
              child: (widget.kontak == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertKontak();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      //update
      await db.updateKontak(Kontak.fromMap({
        'id': widget.kontak!.id,
        'name': name!.text,
        'mobileNo': mobileNo!.text,
        'email': email!.text,
        'company': company!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveKontak(Kontak(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }



}

class Barang{
  String name;
  Barang (this.name);

}