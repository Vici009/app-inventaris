// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, unused_local_variable, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_crud/home.dart';
import 'package:get/get.dart';
import 'database/brg.dart';
import 'database/brg_keluar.dart';
import 'database/brg_masuk.dart';
import 'form_barang.dart';
import 'model/barang.dart';
import 'menu.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris',
      home: Menu(),
    );
  }
}
