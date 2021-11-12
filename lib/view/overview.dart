import 'dart:convert';

import 'package:apps_flutter/class/Members.dart';
import 'package:apps_flutter/class/movies.dart';
import 'package:apps_flutter/class/series.dart';
import 'package:apps_flutter/view/my_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OverviewComponent extends State<Overview>{
  var _members = <Members>[];
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  _loadData() async {
    var url = Uri.parse("https://api-movies-series.herokuapp.com/${widget.movie.type}/${widget.movie.id}");
    var response = await http.get(url);
    setState(() {
      final membersJSON = jsonDecode(response.body);
      for(var members in membersJSON["credits"]["cast"]){
        _members.add(Members(members["name"],members["profile_path"] ?? widget.movie.poster_path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Movies',
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,size: 30.0),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const SmartMoviesAPP())
                );
              }
            ),
            title: const Text("Welcome To Smart Movies"),
            backgroundColor: Colors.redAccent,
          ),
          body: Container(
               color: Colors.black54,
               child:Column(
                 children: [
                   Image.network(
                       widget.movie.backdrop_path,
                       fit: BoxFit.cover
                   ),
                   Container(
                     child: Text(
                       widget.movie.overview,
                       textAlign: TextAlign.justify,
                       style: const TextStyle(fontSize: 18.0,wordSpacing: 0.5,color: Colors.white)
                     ),
                     padding: const EdgeInsets.all(10),
                   ),
                   Expanded(
                     child: ListView.builder(
                       shrinkWrap: true,
                       // scrollDirection: Axis.horizontal,
                       itemCount: _members.length,
                       itemBuilder: (BuildContext context, int index) => Card(
                           child: ListTile(
                              leading: CircleAvatar(
                                foregroundColor: Colors.black,
                                backgroundImage: NetworkImage(_members[index].profile_path),
                              ),
                               title: Text(
                                   _members[index].name,
                                   textAlign: TextAlign.justify,
                                   style: const TextStyle(fontSize: 18.0,wordSpacing: 0.5,color: Colors.white),
                               ),
                           ),
                           color: Colors.black54,
                       ),
                     ),
                   ),
                 ],
               )
          ),
      ),
    );
  }
}
class Overview extends StatefulWidget{
  const Overview({Key? key, required this.movie}) : super(key: key);
  final dynamic movie;


  @override
  createState() => OverviewComponent();
}