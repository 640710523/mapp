import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // state variables
  var _text = "";
  IconData? _icon;

  Widget buildItem({
    required IconData icon,
    required String label,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          //_text = Random().nextInt(100).toString();
          _text = label;
          _icon = icon;
        });
      },
      child: Container(
        width: 100.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(
              label,
              style: GoogleFonts.notoSansThai(
                color: color,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var itemList = [
      buildItem(icon: Icons.phone, label: "โทร", color: Colors.pink),
      buildItem(icon: Icons.route, label: "เส้นทาง", color: Colors.blue),
      buildItem(icon: Icons.share, label: "แชร์", color: Colors.green),
      buildItem(icon: Icons.person, label: "ฉัน", color: Colors.orange),
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _text = "";
                  _icon = null;
                });
              },
              child: Text("Clear"),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_icon, size: 100.0),
                    Text(
                      _text,
                      style: GoogleFonts.kanit(fontSize: 80.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemList,
            ),
          ],
        ),
      ),
    );
  }
}