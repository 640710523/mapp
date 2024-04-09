import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/movies.dart';
import 'package:flutter_project/SeatPage.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
// State variable
  List<movie>? _movies;
  List<movie>? _filteredmovies;
  final TextEditingController _searchController = TextEditingController();

// เมธอดสำหรับโหลดข้อมูล
  void _getmovies() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response =
        await dio.get('https://api.sampleapis.com/movies/comedy');
    List list = jsonDecode(response.data);

    setState(() {
      _movies = list.map((movies) => movie.fromJson(movies)).toList();
       _filteredmovies = _movies;
      //     // เรียงลำดับตามชื่อจาก A ไป Z (กรณีต้องการเรียงลำดับ)
      _movies!.sort((a, b) => a.title.compareTo(b.title));
    });
  }
  void _filtercoffees(String searchTerm) {
    if (searchTerm.isEmpty) {
      setState(() {
        _filteredmovies = _movies;
      });
    } else {
      setState(() {
        _filteredmovies = _movies
            ?.where((movie) =>
                movie.title.toLowerCase().contains(searchTerm.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getmovies();
    _searchController.addListener(() {
      _filtercoffees(_searchController.text);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Ticket',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.red,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredmovies == null
                ? const SizedBox.shrink()
                : ListView.builder(
                    itemCount: _filteredmovies!.length,
                    itemBuilder: (context, index) {
                      var movie = _filteredmovies![index];
                      return ListTile(
                        title: Text(movie.title ?? ''),
                        
                        // leading: Text(country.long_name ?? ''),
                        trailing: movie.posterURL.isNotEmpty
                            ? Image.network(
                                 movie.posterURL,
                                 errorBuilder: (context, error, StackTrace){
                                  return const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Icon(Icons.error));                                                                      
                                 }, 
                            )
                          : const SizedBox(width: 100, height: 100),
                        onTap: () {
                          _showMyDialog(
                              movie.title,
                              movie.imdbId,                              
                              movie.posterURL
                            );
                        },
                      );
                    },
                  ),
          ),
          
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String title,String imdbId,  String image,  ) async {
  movie c = new movie(title: title, imdbId: imdbId,posterURL: image   );
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? ''),
        
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('imdbId : '+ c.imdbId),
              
              Text(
                  'At Ratchaburi',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
              image.isNotEmpty
                  ? Image.network(
                      image,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image not available');
                      },
                    )
                  : const Text('No image available'),
            ],
          ),
        ),
        
        actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('10:00 AM'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('2:00 PM'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('6:00 PM'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}