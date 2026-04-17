import 'package:flutter/material.dart';
import 'baglanti.dart';

class AppDrawer extends StatefulWidget {
  final List<Baglanti> menuelemanlari;

  const AppDrawer({super.key, required this.menuelemanlari});

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.account_tree, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Navigasyon Listesi",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          ...widget.menuelemanlari.map(
            (oge) => ListTile(
              leading: const Icon(Icons.navigation),
              title: Text(oge.ad),
              subtitle: Text("Rota: ${oge.ad}"),
              onTap: () {
                Text("Gidilecek yol: ${oge.yol}");
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
