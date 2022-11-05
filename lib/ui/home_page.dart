import 'package:flutter/material.dart';
import 'package:flutter_crud/database/db_helper.dart';
import 'package:flutter_crud/theme/color.dart';
import 'package:flutter_crud/theme/text_style.dart';

import '../model/barang.dart';
import 'barang_keluar.dart';
import 'barang_masuk.dart';
import 'form_barang.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Barang>? listBarang;
  @override
  void initState() {
    _getAllBarang();
    super.initState();
  }

  Future<void> _getAllBarang() async {
    //list menampung data dari database
    var list = await DbHelper().getAllBarang();
    //ada perubahanan state
    setState(() {
      listBarang = [];
      //hapus data pada listBarang
      listBarang?.clear();

      if (list == null || list.isEmpty) {
        return;
      }
      //lakukan perulangan pada variabel list
      for (var barang in list) {
        //masukan data ke listBarang
        listBarang?.add(Barang.fromMap(barang));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Barang")),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: listBarang == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: listBarang?.length ?? 0,
                      itemBuilder: (context, index) {
                        final barang = listBarang![index];
                        return Column(
                          children: [
                            Dismissible(
                              confirmDismiss: ((direction) async {
                                bool result = false;
                                await showDialog<bool>(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Hapus Data",
                                        style:
                                            AppTextStyle.semiBold(fontSize: 24),
                                      ),
                                      content: Text(
                                        "Apakah anda yakin ingin menghapus ${barang.namaBrg}",
                                        style: AppTextStyle.reg(),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              result = true;
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Ya")),
                                        TextButton(
                                            onPressed: () {
                                              result = false;
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Tidak"))
                                      ],
                                    );
                                  }),
                                );
                                return result;
                              }),
                              onDismissed: (_) async {
                                await DbHelper().deleteBarang(barang.idBrg!);
                              },
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FormBarang(barang: barang),
                                    ),
                                  ).then((_) => _getAllBarang());
                                },
                                leading: const CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(Icons.computer)),
                                title: Text(
                                  "${barang.namaBrg}",
                                  style: AppTextStyle.medium(fontSize: 16),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${barang.deskripsi}"),
                                    UnconstrainedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          // FIXME : GANTI WARNA SESUAI YANG DIMINATI
                                          color: barang.jenis == "Alat"
                                              ? Colors.purple
                                              : Colors.deepOrange,
                                        ),
                                        child: Text(
                                          "${barang.jenis}",
                                          style: AppTextStyle.reg(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  // width: 30,
                                  width: 50,
                                  height: 30,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kPrimaryColor,
                                  ),
                                  // FIXME : PERBAIKI TOTAL BARANG
                                  child: Text(
                                    "${barang.jumlah}/3",
                                    style: AppTextStyle.reg(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),
            ),
            BottomSheet(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormBarang(),
                  ),
                ).then((_) => _getAllBarang());
              },
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final void Function()? onPressed;

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  var position = 0.0;
  var lasPosition = 0.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: position,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 200,
            width: size.width,
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      var tempPosition =
                          size.height - details.globalPosition.dy - 200;
                      if (tempPosition <= 0 && tempPosition >= -150) {
                        setState((() {
                          position = tempPosition;
                        }));
                      }
                    },
                    onVerticalDragEnd: (details) {
                      if ((lasPosition.abs() - position.abs()).abs() > 50) {
                        position = lasPosition == 0 ? -150 : 0;
                        lasPosition = position;
                      } else {
                        position = lasPosition;
                      }
                      setState(() {});
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 48,
                      width: size.width,
                      child: Divider(
                        thickness: 5,
                        height: 48,
                        indent: size.width / 4,
                        endIndent: size.width / 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const BarangMasukPage()),
                          ),
                        );
                      },
                      child: const Text("Barang Masuk"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: ((context) => const BarangKeluarPage()),
                        ),
                        );
                      },
                      child: const Text("Barang Keluar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: -24,
            child: FloatingActionButton(
              onPressed: widget.onPressed,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
