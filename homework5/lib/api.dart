import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homework5/coffees.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
// State variable
  List<coffee>? _coffees;

// เมธอดสำหรับโหลดข้อมูล
  void _getCountries() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response =
        await dio.get('https://api.sampleapis.com/coffee/hot');
    List list = jsonDecode(response.data);

    setState(() {
      _coffees = list.map((cartoons) => coffee.fromJson(cartoons)).toList();

      //     // เรียงลำดับตามชื่อจาก A ไป Z (กรณีต้องการเรียงลำดับ)
      _coffees!.sort((a, b) => a.title.compareTo(b.title));
    });
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Coffee List',style: TextStyle(fontSize: 40.00),),
          Expanded(
            child: _coffees == null
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: _coffees!.length,
                    itemBuilder: (context, index) {
                      var coffee = _coffees![index];
                      return ListTile(
                        title: Text(coffee.title ?? ''),
                        subtitle: Text(coffee.description ?? ''),
                        // leading: Text(country.long_name ?? ''),
                        trailing: Image.network(coffee.image),
                        onTap: () {
                          _showMyDialog(
                              coffee.title,
                              coffee.description,
                              coffee.image,
                              coffee.id);
                        },
                      );
                    },
                  ),
          ),
          
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String title, String image, String description,  int id,) async {
  coffee c = new coffee(title: title, image: image, description: description,  id: id);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? ''),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('description : '+ c.description),
              Image.network(c.image),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}