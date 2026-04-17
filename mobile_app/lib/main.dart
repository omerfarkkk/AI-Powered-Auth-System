import 'package:flutter/material.dart';
import 'DinamikDrawer/loginview.dart';
import 'DinamikDrawer/DinamikDrawerUygulamasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinamik Drawer Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // Başlangıç ekranı olarak sizin LoginView sayfanızı ayarlıyoruz
      home: const LoginView(),

      // Rotaları tanımlıyoruz ki Navigator.pushNamed çalışabilsin
      routes: {
        '/DinamikDrawer': (context) => const DinamikDrawer(),
      },
    );
  }
}