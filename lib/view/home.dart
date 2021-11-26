import 'package:apps_flutter/class/movies.dart';
import 'package:apps_flutter/class/series.dart';
import 'package:apps_flutter/view/overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SmartMovies extends State<SmartMoviesHome>{
  var _movies =  <Movies> [];
  var _series = <Series> [];
  final _font = const TextStyle(fontSize: 18.0,color: Colors.white);
  @override
  void initState(){
    super.initState();
    _loadData();
  }
  _loadData() async {
    var url = Uri.parse("https://api-movies-series.herokuapp.com/filmes");
    var urlSeries = Uri.parse("https://api-movies-series.herokuapp.com/series");
    var response = await http.get(url);
    var responseSeries = await http.get(urlSeries);
    setState(() {
       final moviesJson = jsonDecode(response.body);
       final seriesJson = jsonDecode(responseSeries.body);
       for(var movies in moviesJson["results"]){
         _movies.add(Movies(movies["id"],movies["title"], movies["overview"], movies["poster_path"], movies["backdrop_path"], movies["adult"], movies["popularity"], "filmes"));
       }
       for(var series in seriesJson["results"]){
         _series.add(Series(series["id"], series["original_name"] ?? "Um titulo qualquer", series["overview"]??"", series["poster_path"] ??"", series["backdrop_path"] ?? series["poster_path"] ?? "", series["adult"]??false, series["popularity"], "series"));
       }
    });
  }

  @override
  Widget build(BuildContext context) {
   if(_movies.isEmpty || _series.isEmpty) {
       return const CircularProgressIndicator(
         color: Colors.white,
       );
   }else{
     return Column(
     mainAxisSize: MainAxisSize.min,
     children: [
       // const Expanded(
       //   child: CircularProgressIndicator(),
       // ),
       Expanded(
         child: ListView.builder(
           shrinkWrap: true,
           scrollDirection: Axis.horizontal,
           itemCount: _movies.length,
           itemBuilder: (BuildContext context, int position) =>  Card(
             child:TextButton(onPressed: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>  Overview(movie: _movies[position])),
               );
             },
             child: Container(
               child: Column(
               children: [
                 Image(
                     image:  NetworkImage(_movies[position].backdrop_path),
                     width: 300,
                     height: 200,
                     alignment: Alignment.topCenter,
                     fit: BoxFit.cover
                 ),
                 Text(
                   _movies[position].title,
                   style: _font,
                 )
               ],
             ),
               margin: const EdgeInsets.all(5),
             ),
           )

           ),
         ),
       ),
       Expanded(
         child: ListView.builder(
           shrinkWrap: true,
           scrollDirection: Axis.horizontal,
           itemCount: _series.length,
           itemBuilder: (ctx,int index){
             return Card(
                 child:TextButton(onPressed: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>  Overview(movie: _series[index])),
                   );
                 },
                   child: Container(
                     child: Column(
                       children: [
                         Image(
                             image:  NetworkImage(_series[index].backdrop_path),
                             width: 300,
                             height: 200,
                             alignment: Alignment.topCenter,
                             fit: BoxFit.cover
                         ),
                         Text(
                           _series[index].original_name,
                           style: _font,
                         )
                       ],
                     ),
                     margin: const EdgeInsets.all(5),
                   ),
                 )
             );
           },
         ),
       ),
     ],
    );
  }
  }
}
class SmartMoviesHome extends StatefulWidget{
  const SmartMoviesHome({Key? key}) : super(key: key);

 @override
 createState() => SmartMovies();
}
