import 'package:flutter/material.dart';
import 'package:flutter_crud/theme/color.dart';
import 'package:flutter_crud/theme/text_style.dart';
import 'package:flutter_crud/ui/menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: const [
          BackgroundGradient(),
          CardFormLogin(),
        ],
      ),
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor, kAccentColor],
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: kAccentColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
          HeaderHeadline(size: size),
        ],
      ),
    );
  }
}

class HeaderHeadline extends StatelessWidget {
  const HeaderHeadline({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Lab Inventaris",
              style: AppTextStyle.bold(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Text(
                "Aplikasi pengelola barang beserta pencatatan barang masuk dan keluar.",
                style: AppTextStyle.reg(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardFormLogin extends StatefulWidget {
  const CardFormLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<CardFormLogin> createState() => _CardFormLoginState();
}

class _CardFormLoginState extends State<CardFormLogin> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Login",
                    style: AppTextStyle.bold(fontSize: 32),
                  ),
                  Text(
                    "Silahkan masuk terlebih dahulu",
                    style: AppTextStyle.reg(fontSize: 14),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) return "usename wajib diisi";
                      if (value.isEmpty) return "usename wajib diisi";
                      if (value.length < 4) return "usename minimal 4 karakter";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (value) {
                      if (value == null) return "password wajib diisi";
                      if (value.isEmpty) return "password wajib diisi";
                      if (value.length < 4) {
                        return "password minimal 4 karakter";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final isValid = usernameController.text.toLowerCase() ==
                                "admin" &&
                            passwordController.text.toLowerCase() == "admin";
                        if (isValid) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const Menu()),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              dismissDirection: DismissDirection.horizontal,
                              content: Text(
                                "username atau password salah",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Masuk"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
