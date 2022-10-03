import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'database/db_helper.dart';
import 'form_barang.dart';
import 'model/barang.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Barang> listBarang = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallbarang saat pertama kali dimuat
    _getAllBarang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: const Text('Inventaris'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(listBarang),
                ).then((_) => _getAllBarang());
              }),
        ],
        backgroundColor: Colors.indigoAccent,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormBarang(),
            ),
          ).then((_) => _getAllBarang());
        },
      ),
      drawer: Drawer(
        child: ListView(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormBarang(),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: const Text('List'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ListBarangPage()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: listBarang.length,
          itemBuilder: (context, index) {
            Barang barang = listBarang[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.monitor,
                  size: 50,
                ),
                title: Text('${barang.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Kondisi: ${barang.kondisi}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jumlah: ${barang.jumlah}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Merek: ${barang.merek}"),
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
                            _openFormEdit(barang);
                          },
                          icon: const Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: const Text("Information"),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${barang.name}")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteBarang() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteBarang(barang, index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya")),
                              TextButton(
                                child: const Text('Tidak'),
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
    );
  }

  //mengambil semua data Barang
  Future<void> _getAllBarang() async {
    //list menampung data dari database
    var list = await db.getAllBarang();

    //ada perubahanan state
    setState(() {
      //hapus data pada listBarang
      listBarang.clear();

      //lakukan perulangan pada variabel list
      for (var barang in list!) {
        //masukan data ke listBarang
        listBarang.add(Barang.fromMap(barang));
      }
    });
  }

  //menghapus data Barang
  Future<void> _deleteBarang(Barang barang, int position) async {
    await db.deleteBarang(barang.id!);
    setState(() {
      listBarang.removeAt(position);
    });
  }

  // membuka halaman tambah Barang
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormBarang()));
    if (result == 'save') {
      await _getAllBarang();
    }
  }

  //membuka halaman edit Barang
  Future<void> _openFormEdit(Barang barang) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormBarang(barang: barang)));
    if (result == 'update') {
      await _getAllBarang();
    }
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(this.data);
  final List<Barang> data;
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
    List<Barang> matchQuery = [];
    for (var barang in data) {
      if (barang.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(barang);
      }
    }
    if (matchQuery.isEmpty) {
      return const Center(child: Text("Data tidak ditemukan"));
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(matchQuery[index].name ?? ""),
          onTap: () {
            Get.to(FormBarang(barang: matchQuery[index]));
          },
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
