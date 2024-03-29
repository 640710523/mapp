import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED MATRIX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 102, 55, 182)),
        useMaterial3: true,
      ),
      home: const LedMatrix(),
    );
  }
}

class LedMatrix extends StatefulWidget {
  const LedMatrix({super.key});

  @override
  State<LedMatrix> createState() => _LedMatrixState();
}

class _LedMatrixState extends State<LedMatrix> {
  int num = 0;
  int num2 = 0;
  List<List<List<int>>> dotsList = [
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
    // Digit 1
    [
      [0, 0, 1, 0, 0],
      [0, 1, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 1, 1, 0],
    ],
    // Digit 2
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 1, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 0, 0, 0],
      [1, 1, 1, 1, 1],
    ],
    // Digit 3
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
      [0, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
    // Digit 4
    [
      [0, 0, 0, 1, 0],
      [0, 0, 1, 1, 0],
      [0, 1, 0, 1, 0],
      [1, 0, 0, 1, 0],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 1, 0],
      [0, 0, 0, 1, 0],
    ],
    // Digit 5
    [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0],
      [1, 1, 1, 1, 0],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
    // Digit 6
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 0],
      [1, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
    // Digit 7
    [
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 1, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 0, 0, 0],
      [0, 1, 0, 0, 0],
      [0, 1, 0, 0, 0],
    ],
    // Digit 8
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ],
    // Digit 9
    [
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [0, 1, 1, 1, 0],
    ]
  ];

  Widget _buildDot(int num, int i, int j) {
    var dots = dotsList[num];
    return Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dots[i][j] == 1
            ? Color.fromARGB(255, 126, 206, 126)
            : Color.fromARGB(255, 64, 54, 54),
      ),
    );
  }

  Widget _buildMatrix(int num) {
    List<Widget> rows = [];
    for (int i = 0; i < dotsList[num].length; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < dotsList[num][i].length; j++) {
        rowChildren.add(_buildDot(num, i, j));
      }
      rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center, children: rowChildren));
    }
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: rows);
  }

  Widget _buildDotIncrease() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          if (num2 < 9) {
            num2++;
          } else {
            num2 = 0;
            if (num < 9) {
              num++;
            } else {
              num = 0;
            }
          }
        });
      },
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.arrow_drop_up,
        size: 50.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  Widget _buildDotDecrease() {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          if (num2 > 0) {
            num2--;
          } else {
            num2 = 9;
            if (num > 0) {
              num--;
            } else {
              num = 9;
            }
          }
        });
      },
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.arrow_drop_down,
        size: 50.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CP-SU LED MATRIX',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 180, 187, 255),
      ),
      body: Container(
        color: Color.fromARGB(255, 136, 162, 248),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _buildDotIncrease(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  border: Border.all(color: Colors.white, width: 10.0),
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    _buildMatrix(num),
                    SizedBox(width: 18),
                    _buildMatrix(num2)
                  ],
                ),
              ),
            ],
          ),
          _buildDotDecrease(),
        ]),
      ),
    );
  }
}