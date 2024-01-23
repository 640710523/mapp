import 'package:flutter/material.dart';
import 'dart:math';

// Top-level function
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AppBar _buildAppBar() {
    var firstName = 'Tananon';
    var lastName = 'Chocksombunkaseat';

    // String interpolation
    return AppBar(
      title: Text('$firstName $lastName'),
    );
  }
  Widget _buildPageBody() {
    final List<Map<String, String>> data = [
    {"text": "!! Manchester United !!", "image": "assets/images/ManU.png"},
    {"text": "!! Liverpool FC !!", "image": "assets/images/LIV.png"},
    {"text": "!! Inter Miami CF!!", "image": "assets/images/Miami.png"},
  ];
  Random random = Random();
    int index = random.nextInt(data.length);
    Map<String, String> randomFC = data[index];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
                randomFC["image"]!,
                width: 200,
                fit: BoxFit.fill,
              ),
          Text(
            // Positional parameter
            randomFC["text"]!,
            // Named parameter
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            // Named parameter
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildPageBody(),
      ),
    );
  }
}

