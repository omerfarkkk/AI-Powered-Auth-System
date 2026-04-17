import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../DinamikDrawer/DinamikDrawerUygulamasi.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> girisiTamamla() async {
    var url = Uri.parse("http://10.0.2.2:5000/login");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": userController.text,
        "password": passController.text,
      }),
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DinamikDrawer()),
      );
    } else if (data["status"] == "blocked") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Çok fazla deneme! Engellendin.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hatalı kullanıcı adı veya şifre!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giriş Yap")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: "Kullanıcı Adı",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: girisiTamamla,
              child: const Text("Giriş Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
