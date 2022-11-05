import 'package:flutter/material.dart';
import 'package:flutter_crud/theme/color.dart';
import 'package:flutter_crud/ui/login_page.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: kPrimaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
