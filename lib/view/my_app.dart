import 'package:apps_flutter/view/home.dart';
import 'package:flutter/material.dart';

class SmartMoviesAPP extends StatelessWidget {
  const SmartMoviesAPP({Key? key}) : super(key: key);
  static String id = "home";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Movies',
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Welcome to Smart Movies'),
            backgroundColor: Colors.redAccent,
          ),
          body: const Center(
            child: SmartMoviesHome(),
          )),
    );
  }
}
