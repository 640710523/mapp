import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var _text = "______";
  Widget buildItem({
    required String text,
    required String label,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_text.length <= 6) {
            _text = _text.replaceFirst('_', text);
          }
          //_text2 = label;
        });
      },
      child: Container(
        width: 100.0,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: 12.0,
                    ),
                  ),
                ],
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
      buildItem(text: "1", label: "one", color: Colors.black),
      buildItem(text: "2", label: "two", color: Colors.black),
      buildItem(text: "3", label: "three", color: Colors.black),
      buildItem(text: "4", label: "four", color: Colors.black),
      buildItem(text: "5", label: "five", color: Colors.black),
      buildItem(text: "6", label: "six", color: Colors.black),
      buildItem(text: "7", label: "seven", color: Colors.black),
      buildItem(text: "8", label: "eight", color: Colors.black),
      buildItem(text: "9", label: "nine", color: Colors.black),
      buildItem(text: "0", label: "zero", color: Colors.black),
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            Column(
              children: [
                Icon(
                  Icons.security,
                  size: 50,
                ),
                Text(
                  "PIN LOGIN",
                  style: GoogleFonts.poppins(fontSize: 20
                  ),
                )
              ],
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _text,
                      style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  itemList[i * 3],
                  itemList[i * 3 + 1],
                  itemList[i * 3 + 2]
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _text = "______";
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    ),
                ),
                itemList[9],
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_text.isNotEmpty) {
                        int lastIndex = _text.lastIndexOf(RegExp('[^_]'));
                        if (lastIndex != -1) {
                          _text =
                              _text.replaceRange(lastIndex, lastIndex + 1, '_');
                        }
                      } else {
                        _text = "______";
                      }
                    });
                  },
                  child: Icon(
                    Icons.backspace_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}