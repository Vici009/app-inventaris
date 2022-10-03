// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'form_kontak.dart';

import 'database/db_helper.dart';
import 'home.dart';
import 'model/kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);

  @override
  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(

          title: const Text('Inventaris'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),);
          }


    ),
  ],





        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lime,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FormKontak()),
                );
              },
            ),
            ListTile(
              title: const Text('List'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.monitor,
                  size: 50,
                ),
                title: Text('${kontak.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Kondisi: ${kontak.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jumlah: ${kontak.mobileNo}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Merek: ${kontak.company}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${kontak.name}")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteKontak() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteKontak(kontak, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllKontak() async {
    //list menampung data dari database
    var list = await db.getAllKontak();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listKontak.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((kontak) {
        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  //menghapus data Kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormKontak()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}
class CustomSearchDelegate extends SearchDelegate {

  List<String> searchTerms = [
    'kursi',
    'mouse',
    'monitor',
    'speaker',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (content, index) {
        var result = matchquery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    for (var name in searchTerms) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (content, index) {
        var result = matchquery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

