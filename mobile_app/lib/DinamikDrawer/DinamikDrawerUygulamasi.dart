import 'package:flutter/material.dart';
import 'appdrawer.dart';
import 'baglanti.dart';

class DinamikDrawer extends StatefulWidget {
  const DinamikDrawer({super.key});

  @override
  State<DinamikDrawer> createState() => DinamikDrawerState();
}

class DinamikDrawerState extends State<DinamikDrawer> {
  final List<Baglanti> menuElemanlari = [];

  final TextEditingController adController = TextEditingController();
  final TextEditingController yolController = TextEditingController();

  void Elemanekle() {
    if (adController.text.isNotEmpty && yolController.text.isNotEmpty) {
      setState(() {
        menuElemanlari.add(Baglanti(adController.text, yolController.text));
        adController.clear();
        yolController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yeni rota menüye eklendi!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gelişmiş Dinamik Menü")),
      drawer: AppDrawer(menuelemanlari: menuElemanlari),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: adController,
              decoration: const InputDecoration(
                labelText: "Bağlantı Görünen Adı",
                prefixIcon: Icon(Icons.label),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: yolController,
              decoration: const InputDecoration(
                labelText: "Bağlantı Yolu (Route/URL)",
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: Elemanekle,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text("Listeye ve Drawer'a Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}
