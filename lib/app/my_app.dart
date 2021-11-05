
import 'package:apps_flutter/app/view/home.dart';
import 'package:flutter/material.dart';

class SmartMoviesAPP extends StatelessWidget {
  const SmartMoviesAPP({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Movies',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Welcome to Smart Movies'),
          backgroundColor: Colors.redAccent,
        ),
        body:  const Center(
          child: SmartMoviesHome(),
        )
      ),
    );
  }
}