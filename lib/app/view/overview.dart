import 'package:apps_flutter/app/class/movies.dart';
import 'package:apps_flutter/app/view/home.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget{
  const Overview({Key? key, }) : super(key: key);
  static String id = "overview";
  // final Movies movie;
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
                Navigator.pushNamed(
                  context,
                  "/"
                );
              }
            ),
            title: const Text("Welcome To Smart Movies"),
            backgroundColor: Colors.redAccent,
          ),
          body:  const Center(
            child: Text("movie.title"),
          )
      ),
    );
  }
}