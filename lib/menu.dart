import 'package:flutter/material.dart';
import 'package:flutter_crud/form_barang.dart';
import 'package:flutter_crud/form_barangkeluar.dart';
import 'package:flutter_crud/form_barangmasuk.dart';
import 'home.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  static const String _inventaris = 'Inventaris';

  @override
  Widget build(BuildContext context) {
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return MaterialApp(
      title: _inventaris,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text(_inventaris)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Selamat datang \n di Aplikasi Inventaris \n dibuat oleh \n M.Fikri Rahmatullah',
            maxLines: 4,
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('Kelola Barang'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormBarangMasuk()),
              );
            },
            child: const Text('Barang Masuk'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormBarangKeluar()),
              );
            },
            child: const Text('Barang Keluar'),
          ),
        ],
      ),
    );
  }
}
