import 'package:apps_flutter/app/class/movies.dart';
import 'package:apps_flutter/app/view/overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SmartMovies extends State<SmartMoviesHome>{

  var _movies =  <Movies> [];
  final _font = const TextStyle(fontSize: 20.0);
  @override
  void initState(){
    super.initState();
    _loadData();
  }
  _loadData() async {
    var url = Uri.parse("https://api-movies-series.herokuapp.com/filmes");
    var response = await http.get(url);
    setState(() {
       final moviesJson = jsonDecode(response.body);
       for(var movies in moviesJson["results"]){
         _movies.add(Movies(movies["title"], movies["poster_path"], movies["backdrop_path"], movies["overview"], movies["adult"], movies["popularity"]));
       }
    });
  }
  Widget _buildRow(int position){
      return ListTile(
        title: Text(_movies[position].title, style: _font),
        leading: CircleAvatar(
          backgroundColor: Colors.black87,
          backgroundImage: NetworkImage(_movies[position].poster_path),
        ),
        onTap:()  {
          Navigator.pushNamed(
              context,
              "/overview"
          );
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _movies.length,
      itemBuilder: (BuildContext context, int position){
        return _buildRow(position);
    },
    );
  }
}
class SmartMoviesHome extends StatefulWidget{
  const SmartMoviesHome({Key? key}) : super(key: key);

 @override
 createState() => SmartMovies();
}
